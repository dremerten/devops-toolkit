#!/bin/bash
set -e

# Reconfigure NGINX Ingress to listen on ports 80/443 directly
# Changes from NodePort to HostPort binding

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

SSH_HOST="${1:-hostinger}"

echo -e "${BLUE}============================================${NC}"
echo -e "${BLUE}Fix NGINX Ingress Port Binding${NC}"
echo -e "${BLUE}============================================${NC}"
echo ""

echo -e "${YELLOW}This will reconfigure NGINX Ingress to listen on ports 80/443${NC}"
echo -e "${YELLOW}instead of NodePort 30080/30443${NC}"
echo ""

read -p "Continue? (yes/no): " -r
if [[ ! $REPLY =~ ^[Yy]es$ ]]; then
    echo "Cancelled."
    exit 0
fi

echo ""
echo -e "${YELLOW}[1/3] Checking current NGINX Ingress configuration...${NC}"

ssh "$SSH_HOST" bash << 'ENDSSH'
set -e

echo "Current NGINX Ingress Service:"
kubectl get svc -n ingress-nginx ingress-nginx-controller

echo ""
echo "Current Service Type:"
kubectl get svc -n ingress-nginx ingress-nginx-controller -o jsonpath='{.spec.type}'
echo ""
ENDSSH

echo ""
echo -e "${YELLOW}[2/3] Patching NGINX Ingress to use HostPort...${NC}"

ssh "$SSH_HOST" bash << 'ENDSSH'
set -e

# Delete the existing service (will be recreated)
kubectl delete svc -n ingress-nginx ingress-nginx-controller

# Patch the deployment to use hostNetwork (binds directly to ports 80/443)
kubectl patch deployment ingress-nginx-controller -n ingress-nginx --type='json' -p='[
  {
    "op": "add",
    "path": "/spec/template/spec/hostNetwork",
    "value": true
  },
  {
    "op": "add",
    "path": "/spec/template/spec/dnsPolicy",
    "value": "ClusterFirstWithHostNet"
  }
]'

# Wait for pods to restart
echo "Waiting for NGINX Ingress pods to restart with new configuration..."
kubectl rollout status deployment ingress-nginx-controller -n ingress-nginx --timeout=120s

# Recreate the service as ClusterIP (not needed with hostNetwork but good to have)
kubectl expose deployment ingress-nginx-controller -n ingress-nginx \
  --name=ingress-nginx-controller \
  --type=ClusterIP \
  --port=80 \
  --target-port=80 \
  --dry-run=client -o yaml | kubectl apply -f -

echo "✓ NGINX Ingress reconfigured"
ENDSSH

echo -e "${GREEN}✓ Patch applied${NC}"

echo ""
echo -e "${YELLOW}[3/3] Verifying port binding...${NC}"

ssh "$SSH_HOST" bash << 'ENDSSH'
set -e

echo "Waiting 10 seconds for ports to bind..."
sleep 10

echo ""
echo "Checking ports 80 and 443:"
if netstat -tulpen | grep -E ':(80|443) ' | grep LISTEN; then
    echo ""
    echo "✓ Ports 80 and 443 are now listening!"
else
    echo ""
    echo "⚠ Ports not yet bound. Checking pod status..."
    kubectl get pods -n ingress-nginx -l app.kubernetes.io/component=controller
fi

echo ""
echo "NGINX Ingress Controller pods:"
kubectl get pods -n ingress-nginx -l app.kubernetes.io/component=controller
ENDSSH

echo ""
echo -e "${GREEN}============================================${NC}"
echo -e "${GREEN}NGINX Ingress Port Fix Complete!${NC}"
echo -e "${GREEN}============================================${NC}"
echo ""

echo -e "${BLUE}Verification:${NC}"
echo ""
echo "1. Check ports are listening on remote VPS:"
echo -e "   ${YELLOW}ssh $SSH_HOST 'netstat -tulpen | grep -E \":(80|443)\" | grep LISTEN'${NC}"
echo ""
echo "2. Test HTTP access:"
echo -e "   ${YELLOW}curl -I http://89.116.212.35${NC}"
echo ""
echo "3. Deploy applications and check certificates:"
echo -e "   ${YELLOW}./scripts/check-certs.sh${NC}"
echo ""
