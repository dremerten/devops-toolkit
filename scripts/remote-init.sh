#!/bin/bash
set -e

# Remote VPS Initialization Script (Run from Local Laptop)
# This script uploads the k3s installer to your VPS and executes it remotely

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Load environment variables from .env file
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
ENV_FILE="$PROJECT_ROOT/.env"

if [ -f "$ENV_FILE" ]; then
    echo -e "${BLUE}Loading configuration from .env file...${NC}"
    # Export variables from .env, ignoring comments and empty lines
    set -a
    source "$ENV_FILE"
    set +a
else
    echo -e "${YELLOW}Warning: .env file not found at $ENV_FILE${NC}"
    echo -e "${YELLOW}Please copy .env.example to .env and configure it${NC}"
    echo ""
    read -p "Continue without .env file? (yes/no): " -r
    if [[ ! $REPLY =~ ^[Yy]es$ ]]; then
        echo "Setup cancelled."
        exit 1
    fi
fi

# Check if VPS host/IP is provided
if [ -z "$1" ]; then
    echo -e "${RED}Error: VPS host or IP address required${NC}"
    echo ""
    echo "Usage:"
    echo "  ./scripts/remote-init.sh <SSH_HOST> [YOUR_EMAIL]"
    echo ""
    echo "Examples:"
    echo "  ./scripts/remote-init.sh hostinger admin@dremer10.com"
    echo "  ./scripts/remote-init.sh 192.168.1.100 admin@dremer10.com"
    echo ""
    echo "SSH_HOST can be:"
    echo "  - An SSH alias from ~/.ssh/config (e.g., 'hostinger')"
    echo "  - An IP address (e.g., '192.168.1.100')"
    echo ""
    echo "The email is optional and will be used for Let's Encrypt certificates."
    exit 1
fi

SSH_HOST=""
AUTO_CONFIRM=false

# Parse arguments
for arg in "$@"; do
    if [ "$arg" = "--yes" ] || [ "$arg" = "-y" ]; then
        AUTO_CONFIRM=true
    elif [ -z "$SSH_HOST" ]; then
        SSH_HOST="$arg"
    else
        # Allow command-line email to override .env
        EMAIL="$arg"
    fi
done

# If SSH_HOST is still empty, it means no positional arg was provided
if [ -z "$SSH_HOST" ]; then
    SSH_HOST="$1"
    # If EMAIL not set from command line, use second arg or error out
    if [ -z "$EMAIL" ]; then
        EMAIL="$2"
    fi
fi

# Validate EMAIL is set
if [ -z "$EMAIL" ]; then
    echo -e "${RED}Error: EMAIL is not configured${NC}"
    echo ""
    echo "Please either:"
    echo "  1. Set EMAIL in .env file (recommended)"
    echo "  2. Pass email as second argument: $0 <SSH_HOST> <EMAIL>"
    echo ""
    exit 1
fi

# Detect actual IP address from the VPS
echo -e "${BLUE}Detecting VPS IP address...${NC}"
VPS_IP=$(ssh "$SSH_HOST" "curl -4 -s ifconfig.me 2>/dev/null || hostname -I | awk '{print \$1}'")
if [ -z "$VPS_IP" ]; then
    echo -e "${RED}Failed to detect VPS IP address${NC}"
    exit 1
fi

echo "========================================="
echo "DevOps-Toolkit Remote VPS Setup"
echo "========================================="
echo ""
echo -e "${GREEN}SSH Host: $SSH_HOST${NC}"
echo -e "${GREEN}VPS IP: $VPS_IP${NC}"
echo -e "${GREEN}Email for certs: $EMAIL${NC}"
echo ""
echo -e "${YELLOW}This will:${NC}"
echo "  1. Upload k3s installation script to VPS"
echo "  2. Execute installation remotely via SSH"
echo "  3. Install k3s, NGINX Ingress, cert-manager, and Helm"
echo ""

if [ "$AUTO_CONFIRM" = false ]; then
    read -p "Continue? (yes/no): " -r
    if [[ ! $REPLY =~ ^[Yy]es$ ]]; then
        echo "Installation cancelled."
        exit 0
    fi
else
    echo "Auto-confirming installation (--yes flag provided)..."
fi

# Test SSH connection
echo ""
echo -e "${BLUE}Testing SSH connection...${NC}"
if ! ssh -o ConnectTimeout=5 "$SSH_HOST" "echo 'SSH connection successful'" &>/dev/null; then
    echo -e "${RED}Failed to connect to VPS via SSH${NC}"
    echo ""
    echo "Please ensure:"
    echo "  1. You can SSH to the VPS: ssh $SSH_HOST"
    echo "  2. SSH keys are set up or you have the root password"
    echo "  3. The SSH host/IP is correct"
    exit 1
fi
echo -e "${GREEN}✓ SSH connection successful${NC}"

# Upload installation script
echo ""
echo -e "${BLUE}Uploading k3s installation script to VPS...${NC}"
if scp scripts/k3s-install.sh "$SSH_HOST":/root/k3s-install.sh; then
    echo -e "${GREEN}✓ Script uploaded successfully${NC}"
else
    echo -e "${RED}Failed to upload script${NC}"
    exit 1
fi

# Execute installation remotely
echo ""
echo -e "${BLUE}Executing k3s installation on VPS...${NC}"
echo -e "${YELLOW}This will take 5-10 minutes. Please wait...${NC}"
echo ""

if [ "$AUTO_CONFIRM" = true ]; then
    ssh -t "$SSH_HOST" "export SERVER_IP=$VPS_IP && export EMAIL=$EMAIL && chmod +x /root/k3s-install.sh && bash /root/k3s-install.sh --yes"
else
    ssh -t "$SSH_HOST" "export SERVER_IP=$VPS_IP && export EMAIL=$EMAIL && chmod +x /root/k3s-install.sh && bash /root/k3s-install.sh"
fi

echo ""
echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}Remote VPS Setup Complete!${NC}"
echo -e "${GREEN}=========================================${NC}"
echo ""
echo -e "${BLUE}Next Steps:${NC}"
echo ""
echo "1. Sync kubeconfig to your local machine:"
echo -e "   ${YELLOW}./scripts/sync-kubeconfig.sh $SSH_HOST${NC}"
echo -e "   ${YELLOW}# Or use Makefile: make sync VPS_IP=$SSH_HOST${NC}"
echo ""
echo "2. Verify cluster is accessible:"
echo -e "   ${YELLOW}kubectl --kubeconfig ~/.kube/config-dremer10 get nodes${NC}"
echo ""
echo "3. Update cert-manager with your email:"
echo -e "   ${YELLOW}Edit kubernetes/cert-manager/cert-manager-install.yaml${NC}"
echo -e "   ${YELLOW}Change 'your-email@example.com' to '$EMAIL'${NC}"
echo ""
echo "4. Build and push Docker image:"
echo -e "   ${YELLOW}./scripts/build-and-push.sh${NC}"
echo ""
echo "5. Deploy application:"
echo -e "   ${YELLOW}./scripts/deploy.sh${NC}"
echo ""
