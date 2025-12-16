#!/bin/bash
set -e

# Switch from Let's Encrypt Staging to Production Certificates
# Run this ONLY after verifying staging certificates are working

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Get script directory and project root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

echo -e "${BLUE}============================================${NC}"
echo -e "${BLUE}Switch to Production TLS Certificates${NC}"
echo -e "${BLUE}============================================${NC}"
echo ""

echo -e "${YELLOW}IMPORTANT: This will switch from staging to production Let's Encrypt certificates.${NC}"
echo -e "${YELLOW}Production has rate limits (50 certs/week). Only proceed if staging works!${NC}"
echo ""

# Check current certificates
echo -e "${BLUE}Current Certificate Status:${NC}"
kubectl get certificate -A
echo ""

read -p "Have you verified staging certificates are working? (yes/no): " -r
if [[ ! $REPLY =~ ^[Yy]es$ ]]; then
    echo "Cancelled. Please verify staging certificates first:"
    echo "  kubectl get certificate -A"
    echo "  kubectl describe certificate -n production devops-toolkit-production-tls"
    exit 0
fi

echo ""
echo -e "${YELLOW}[1/3] Updating ingress annotations to use letsencrypt-prod...${NC}"

# Update all ingress files
find "$PROJECT_ROOT/kubernetes/ingress" -name "*.yaml" -type f -exec sed -i 's/letsencrypt-staging/letsencrypt-prod/g' {} \;

echo -e "${GREEN}✓ Updated all ingress files${NC}"

echo ""
echo -e "${YELLOW}[2/3] Deleting existing staging certificates...${NC}"

# Delete staging certificates to force re-issuance with production
kubectl delete certificate --all -n production 2>/dev/null || true
kubectl delete certificate --all -n staging 2>/dev/null || true
kubectl delete certificate --all -n qa 2>/dev/null || true
kubectl delete certificate --all -n dev 2>/dev/null || true
kubectl delete certificate --all -n monitoring 2>/dev/null || true
kubectl delete certificate --all -n ci-cd 2>/dev/null || true

echo -e "${GREEN}✓ Deleted staging certificates${NC}"

echo ""
echo -e "${YELLOW}[3/3] Applying updated ingress configurations...${NC}"

# Apply all ingress files
kubectl apply -f "$PROJECT_ROOT/kubernetes/ingress/"

echo -e "${GREEN}✓ Applied updated ingresses${NC}"

echo ""
echo -e "${GREEN}============================================${NC}"
echo -e "${GREEN}Switched to Production Certificates!${NC}"
echo -e "${GREEN}============================================${NC}"
echo ""

echo -e "${BLUE}Next Steps:${NC}"
echo ""
echo "1. Monitor certificate issuance (may take 2-5 minutes):"
echo -e "   ${YELLOW}watch kubectl get certificate -A${NC}"
echo ""
echo "2. Check certificate details:"
echo -e "   ${YELLOW}kubectl describe certificate -n production devops-toolkit-production-tls${NC}"
echo ""
echo "3. View cert-manager logs if issues occur:"
echo -e "   ${YELLOW}kubectl logs -n cert-manager -l app=cert-manager --tail=50${NC}"
echo ""
echo "4. Once certificates show Ready=True, test your domains in browser:"
echo "   - https://devops-toolkit.dremer10.com"
echo "   - https://staging-devops-toolkit.dremer10.com"
echo "   - https://grafana.devops-toolkit.dremer10.com"
echo ""
echo -e "${GREEN}✓ Certificates should now be trusted by browsers!${NC}"
echo ""
