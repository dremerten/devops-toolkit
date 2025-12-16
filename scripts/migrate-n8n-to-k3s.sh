#!/bin/bash
set -e

# Migrate n8n from Docker to k3s
# This script stops Traefik/n8n containers and prepares for k3s deployment

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

SSH_HOST="${1:-hostinger}"

echo -e "${BLUE}============================================${NC}"
echo -e "${BLUE}Migrate n8n from Docker to k3s${NC}"
echo -e "${BLUE}============================================${NC}"
echo ""

echo -e "${YELLOW}Current n8n URL: ${NC}https://n8n.srv1186137.hstgr.cloud"
echo -e "${YELLOW}New n8n URL:     ${NC}https://n8n.dremer10.com"
echo ""

echo -e "${YELLOW}This will:${NC}"
echo "  1. Stop Traefik and n8n Docker containers"
echo "  2. Free up ports 80 and 443 for NGINX Ingress"
echo "  3. Backup n8n data"
echo "  4. Deploy n8n to k3s"
echo ""
echo -e "${RED}WARNING: After migration, n8n will only be accessible at n8n.dremer10.com${NC}"
echo -e "${RED}The old URL (n8n.srv1186137.hstgr.cloud) will stop working${NC}"
echo ""

# Check DNS before proceeding
echo -e "${YELLOW}Checking DNS for n8n.dremer10.com...${NC}"
DNS_IP=$(dig +short n8n.dremer10.com @8.8.8.8 | tail -n1)
VPS_IP=$(ssh "$SSH_HOST" "curl -4 -s ifconfig.me 2>/dev/null" 2>/dev/null || echo "89.116.212.35")

if [ -z "$DNS_IP" ]; then
    echo -e "${RED}✗ DNS not configured for n8n.dremer10.com${NC}"
    echo ""
    echo "Please add this DNS record in Squarespace first:"
    echo -e "  ${YELLOW}n8n.dremer10.com → A → $VPS_IP${NC}"
    echo ""
    echo "After adding DNS:"
    echo "  1. Wait 5-10 minutes for propagation"
    echo "  2. Re-run this script"
    exit 1
elif [ "$DNS_IP" != "$VPS_IP" ]; then
    echo -e "${RED}✗ DNS points to wrong IP: $DNS_IP (expected: $VPS_IP)${NC}"
    echo ""
    echo "Please update DNS record in Squarespace:"
    echo -e "  ${YELLOW}n8n.dremer10.com → A → $VPS_IP${NC}"
    exit 1
else
    echo -e "${GREEN}✓ DNS configured correctly: $DNS_IP${NC}"
fi

echo ""
read -p "Continue with migration? (yes/no): " -r
if [[ ! $REPLY =~ ^[Yy]es$ ]]; then
    echo "Cancelled."
    exit 0
fi

echo ""
echo -e "${YELLOW}[1/5] Finding and backing up n8n data...${NC}"

ssh "$SSH_HOST" bash << 'ENDSSH'
set -e

# Find n8n data directory from Docker volume
N8N_DATA_DIR=$(docker inspect root-n8n-1 2>/dev/null | grep -A 1 '"Destination": "/home/node/.n8n"' | grep "Source" | awk -F'"' '{print $4}' || echo "")

if [ -z "$N8N_DATA_DIR" ]; then
    echo "Warning: Could not find n8n data directory from container inspect"
    # Try common locations
    for dir in "/root/.n8n" "/var/lib/docker/volumes"/*"n8n"*; do
        if [ -d "$dir" ]; then
            N8N_DATA_DIR="$dir"
            break
        fi
    done
fi

if [ -d "$N8N_DATA_DIR" ]; then
    BACKUP_DIR="/root/n8n-backup-$(date +%Y%m%d-%H%M%S)"
    echo "Found n8n data at: $N8N_DATA_DIR"
    echo "Creating backup at: $BACKUP_DIR"
    cp -r "$N8N_DATA_DIR" "$BACKUP_DIR"
    echo "✓ Backup created: $BACKUP_DIR"

    # Save the path for later migration to k8s PVC
    echo "$N8N_DATA_DIR" > /tmp/n8n-data-path.txt
else
    echo "⚠ Warning: n8n data directory not found"
    echo "  This is OK if you want to start fresh"
fi
ENDSSH

echo -e "${GREEN}✓ Backup complete${NC}"

echo ""
echo -e "${YELLOW}[2/5] Stopping Traefik and n8n containers...${NC}"

ssh "$SSH_HOST" bash << 'ENDSSH'
set -e

# Stop containers
docker stop root-traefik-1 root-n8n-1 || true

echo "✓ Containers stopped"

# Verify ports are free
sleep 3
if ! netstat -tuln | grep -q ':80 '; then
    echo "✓ Port 80 is now free"
else
    echo "⚠ Warning: Port 80 still in use"
    netstat -tuln | grep ':80'
fi

if ! netstat -tuln | grep -q ':443 '; then
    echo "✓ Port 443 is now free"
else
    echo "⚠ Warning: Port 443 still in use"
    netstat -tuln | grep ':443'
fi
ENDSSH

echo -e "${GREEN}✓ Containers stopped${NC}"

echo ""
echo -e "${YELLOW}[3/5] Restarting k3s to bind NGINX Ingress to ports 80/443...${NC}"

ssh "$SSH_HOST" bash << 'ENDSSH'
set -e

# Restart k3s
systemctl restart k3s

# Wait for k3s to be ready
echo "Waiting for k3s to restart..."
sleep 10

# Wait for nodes to be ready
kubectl wait --for=condition=Ready node --all --timeout=60s

echo "✓ k3s restarted"
ENDSSH

echo -e "${GREEN}✓ k3s restarted${NC}"

echo ""
echo -e "${YELLOW}[4/5] Verifying NGINX Ingress Controller...${NC}"

ssh "$SSH_HOST" bash << 'ENDSSH'
set -e

# Wait for NGINX Ingress pods
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=120s

echo ""
echo "NGINX Ingress Controller status:"
kubectl get pods -n ingress-nginx -l app.kubernetes.io/component=controller

echo ""
echo "NGINX Ingress Service:"
kubectl get svc -n ingress-nginx ingress-nginx-controller
ENDSSH

echo ""
echo -e "${YELLOW}[5/6] Deploying n8n to k3s...${NC}"

# Auto-detect kubeconfig if not set
if [ -z "$KUBECONFIG" ] && [ -f "$HOME/.kube/config-dremer10" ]; then
    export KUBECONFIG="$HOME/.kube/config-dremer10"
fi

# Get project root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Deploy n8n
echo "Deploying n8n deployment..."
kubectl apply -f "$PROJECT_ROOT/kubernetes/deployments/n8n.yaml"

echo ""
echo "Waiting for n8n pod to be ready..."
kubectl wait --for=condition=ready pod -l app=n8n -n n8n --timeout=120s || true

echo ""
echo "n8n deployment status:"
kubectl get pods -n n8n

echo -e "${GREEN}✓ n8n deployed to k8s${NC}"

echo ""
echo -e "${YELLOW}[6/6] Deploying n8n ingress...${NC}"

kubectl apply -f "$PROJECT_ROOT/kubernetes/ingress/n8n-ingress.yaml"

echo -e "${GREEN}✓ n8n ingress created${NC}"

echo ""
echo -e "${GREEN}============================================${NC}"
echo -e "${GREEN}Migration Complete!${NC}"
echo -e "${GREEN}============================================${NC}"
echo ""
echo -e "${BLUE}Status:${NC}"
echo -e "  ${GREEN}✓${NC} Traefik stopped"
echo -e "  ${GREEN}✓${NC} n8n migrated to k3s"
echo -e "  ${GREEN}✓${NC} Ports 80/443 freed for NGINX Ingress"
echo -e "  ${YELLOW}⏳${NC} Waiting for SSL certificate (2-5 minutes)"
echo ""
echo -e "${BLUE}Next Steps:${NC}"
echo ""
echo "1. Check certificate status (wait 2-5 minutes):"
echo -e "   ${YELLOW}./scripts/check-certs.sh${NC}"
echo ""
echo "2. Once all certificates show Ready=True, switch to production:"
echo -e "   ${YELLOW}./scripts/switch-to-prod-certs.sh${NC}"
echo ""
echo "3. Access n8n at the new URL:"
echo -e "   ${YELLOW}https://n8n.dremer10.com${NC}"
echo ""
echo -e "${BLUE}Important Notes:${NC}"
echo -e "  • Old URL ${RED}https://n8n.srv1186137.hstgr.cloud will no longer work${NC}"
echo -e "  • Update any bookmarks/webhooks to use ${GREEN}https://n8n.dremer10.com${NC}"
echo -e "  • All n8n data has been preserved in the backup"
echo ""
echo -e "${BLUE}To rollback (restore Docker setup):${NC}"
echo -e "   ${YELLOW}ssh $SSH_HOST 'systemctl stop k3s && docker start root-traefik-1 root-n8n-1'${NC}"
echo ""
