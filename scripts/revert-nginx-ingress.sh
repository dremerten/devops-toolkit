#!/bin/bash
set -e

# Revert NGINX Ingress to original state

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

SSH_HOST="${1:-hostinger}"

echo -e "${BLUE}============================================${NC}"
echo -e "${BLUE}Revert NGINX Ingress Configuration${NC}"
echo -e "${BLUE}============================================${NC}"
echo ""

echo -e "${YELLOW}This will reinstall NGINX Ingress Controller to default state${NC}"
echo ""

read -p "Continue? (yes/no): " -r
if [[ ! $REPLY =~ ^[Yy]es$ ]]; then
    echo "Cancelled."
    exit 0
fi

echo ""
echo -e "${YELLOW}[1/2] Deleting failed NGINX Ingress deployment...${NC}"

ssh "$SSH_HOST" bash << 'ENDSSH'
set -e

# Delete the failed deployment
kubectl delete deployment ingress-nginx-controller -n ingress-nginx --ignore-not-found=true

# Delete the service
kubectl delete svc ingress-nginx-controller -n ingress-nginx --ignore-not-found=true

echo "✓ Deleted failed resources"
ENDSSH

echo -e "${GREEN}✓ Cleanup complete${NC}"

echo ""
echo -e "${YELLOW}[2/2] Reinstalling NGINX Ingress Controller...${NC}"

ssh "$SSH_HOST" bash << 'ENDSSH'
set -e

# Reinstall NGINX Ingress using the original manifest
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.10.0/deploy/static/provider/baremetal/deploy.yaml

# Wait for deployment to be created
sleep 10

# Wait for pods to be ready
echo "Waiting for NGINX Ingress Controller pods to be ready..."
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=300s

echo ""
echo "NGINX Ingress Controller status:"
kubectl get pods -n ingress-nginx -l app.kubernetes.io/component=controller

echo ""
echo "NGINX Ingress Service:"
kubectl get svc -n ingress-nginx ingress-nginx-controller

echo "✓ NGINX Ingress reinstalled successfully"
ENDSSH

echo ""
echo -e "${GREEN}============================================${NC}"
echo -e "${GREEN}NGINX Ingress Reverted to Default${NC}"
echo -e "${GREEN}============================================${NC}"
echo ""

echo -e "${BLUE}Next steps:${NC}"
echo ""
echo "1. Free ports 80 and 443:"
echo -e "   ${YELLOW}./scripts/free-ports-80-443.sh${NC}"
echo ""
echo "2. Apply port fix again:"
echo -e "   ${YELLOW}./scripts/fix-nginx-ingress-ports.sh${NC}"
echo ""
