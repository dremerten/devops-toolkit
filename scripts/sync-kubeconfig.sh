#!/bin/bash
set -e

# Sync kubeconfig from remote VPS to local laptop

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Check if VPS host/IP is provided
if [ -z "$1" ]; then
    echo -e "${RED}Error: VPS host or IP address required${NC}"
    echo ""
    echo "Usage:"
    echo "  ./scripts/sync-kubeconfig.sh <SSH_HOST>"
    echo ""
    echo "Examples:"
    echo "  ./scripts/sync-kubeconfig.sh hostinger"
    echo "  ./scripts/sync-kubeconfig.sh 192.168.1.100"
    echo ""
    echo "SSH_HOST can be:"
    echo "  - An SSH alias from ~/.ssh/config (e.g., 'hostinger')"
    echo "  - An IP address (e.g., '192.168.1.100')"
    exit 1
fi

SSH_HOST="$1"
KUBECONFIG_PATH="$HOME/.kube/config-dremer10"

# Detect actual IP address from the VPS
echo -e "${BLUE}Detecting VPS IP address...${NC}"
VPS_IP=$(ssh "$SSH_HOST" "curl -4 -s ifconfig.me 2>/dev/null || hostname -I | awk '{print \$1}'")
if [ -z "$VPS_IP" ]; then
    echo -e "${RED}Failed to detect VPS IP address${NC}"
    exit 1
fi

echo "========================================="
echo "Syncing kubeconfig from VPS"
echo "========================================="
echo ""
echo -e "${GREEN}SSH Host: $SSH_HOST${NC}"
echo -e "${GREEN}VPS IP: $VPS_IP${NC}"
echo -e "${GREEN}Local kubeconfig: $KUBECONFIG_PATH${NC}"
echo ""

# Create .kube directory if it doesn't exist
mkdir -p ~/.kube

# Backup existing kubeconfig if it exists
if [ -f "$KUBECONFIG_PATH" ]; then
    BACKUP_PATH="$KUBECONFIG_PATH.backup.$(date +%Y%m%d-%H%M%S)"
    echo -e "${YELLOW}Backing up existing kubeconfig to: $BACKUP_PATH${NC}"
    cp "$KUBECONFIG_PATH" "$BACKUP_PATH"
fi

# Download kubeconfig from VPS
echo -e "${BLUE}Downloading kubeconfig from VPS...${NC}"
if scp "$SSH_HOST":/etc/rancher/k3s/k3s.yaml "$KUBECONFIG_PATH"; then
    echo -e "${GREEN}Kubeconfig downloaded successfully!${NC}"
else
    echo -e "${RED}Failed to download kubeconfig${NC}"
    echo "Please ensure:"
    echo "  1. You can SSH to the VPS: ssh $SSH_HOST"
    echo "  2. k3s is installed on the VPS"
    echo "  3. The file /etc/rancher/k3s/k3s.yaml exists"
    exit 1
fi

# Update server address in kubeconfig
echo -e "${BLUE}Updating server address to $VPS_IP...${NC}"
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    sed -i '' "s/127.0.0.1/$VPS_IP/g" "$KUBECONFIG_PATH"
else
    # Linux
    sed -i "s/127.0.0.1/$VPS_IP/g" "$KUBECONFIG_PATH"
fi

# Set proper permissions
chmod 600 "$KUBECONFIG_PATH"

# Test connection
echo ""
echo -e "${BLUE}Testing connection to cluster...${NC}"
if kubectl --kubeconfig "$KUBECONFIG_PATH" cluster-info &>/dev/null; then
    echo -e "${GREEN}✓ Successfully connected to cluster!${NC}"
    echo ""
    echo "Cluster info:"
    kubectl --kubeconfig "$KUBECONFIG_PATH" cluster-info
    echo ""
    echo "Nodes:"
    kubectl --kubeconfig "$KUBECONFIG_PATH" get nodes
else
    echo -e "${RED}✗ Failed to connect to cluster${NC}"
    echo "Please check:"
    echo "  1. Firewall allows port 6443"
    echo "  2. k3s is running on the VPS"
    echo "  3. VPS IP is correct"
    exit 1
fi

echo ""
echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}Kubeconfig Sync Complete!${NC}"
echo -e "${GREEN}=========================================${NC}"
echo ""
echo -e "${BLUE}Usage:${NC}"
echo ""
echo "Option 1: Use with --kubeconfig flag:"
echo -e "  ${YELLOW}kubectl --kubeconfig $KUBECONFIG_PATH get pods -A${NC}"
echo ""
echo "Option 2: Set as environment variable (session only):"
echo -e "  ${YELLOW}export KUBECONFIG=$KUBECONFIG_PATH${NC}"
echo -e "  ${YELLOW}kubectl get pods -A${NC}"
echo ""
echo "Option 3: Set as default (add to ~/.bashrc or ~/.zshrc):"
echo -e "  ${YELLOW}echo 'export KUBECONFIG=$KUBECONFIG_PATH' >> ~/.bashrc${NC}"
echo ""
echo -e "${BLUE}Recommended:${NC} Add this to your shell profile to use automatically:"
echo -e "  ${YELLOW}export KUBECONFIG=$KUBECONFIG_PATH${NC}"
echo ""
