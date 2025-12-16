#!/bin/bash

# Check Certificate Status Across All Environments
# Verifies that staging certificates are working before switching to production

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}============================================${NC}"
echo -e "${BLUE}Certificate Status Check${NC}"
echo -e "${BLUE}============================================${NC}"
echo ""

# Auto-detect kubeconfig if not set
if [ -z "$KUBECONFIG" ] && [ -f "$HOME/.kube/config-dremer10" ]; then
    export KUBECONFIG="$HOME/.kube/config-dremer10"
    echo -e "${BLUE}Using kubeconfig: $KUBECONFIG${NC}"
    echo ""
fi

# Check if kubectl is configured
if ! kubectl cluster-info &>/dev/null; then
    echo -e "${RED}Error: Cannot connect to Kubernetes cluster${NC}"
    echo ""
    echo "Please ensure:"
    echo "  1. You've synced kubeconfig: make sync VPS_IP=hostinger"
    echo "  2. Port 6443 is open on your VPS firewall"
    echo "  3. KUBECONFIG is set: export KUBECONFIG=~/.kube/config-dremer10"
    exit 1
fi

echo -e "${YELLOW}Checking all certificates...${NC}"
echo ""

# Get all certificates
CERTS=$(kubectl get certificate -A --no-headers 2>/dev/null)

if [ -z "$CERTS" ]; then
    echo -e "${YELLOW}No certificates found yet.${NC}"
    echo ""
    echo "This is normal if you haven't deployed applications yet."
    echo ""
    echo "Next steps:"
    echo -e "  1. Deploy applications: ${YELLOW}./scripts/deploy-all-envs.sh${NC}"
    echo -e "  2. Wait 2-5 minutes for certificates to be issued"
    echo -e "  3. Re-run this script: ${YELLOW}./scripts/check-certs.sh${NC}"
    exit 0
fi

# Display certificate status
echo -e "${BLUE}Certificate Status by Namespace:${NC}"
echo ""
kubectl get certificate -A

echo ""
echo -e "${BLUE}Detailed Status:${NC}"
echo ""

# Check each certificate
ALL_READY=true
STAGING_COUNT=0
PROD_COUNT=0

while IFS= read -r line; do
    NAMESPACE=$(echo "$line" | awk '{print $1}')
    NAME=$(echo "$line" | awk '{print $2}')
    READY=$(echo "$line" | awk '{print $3}')

    # Get issuer name
    ISSUER=$(kubectl get certificate -n "$NAMESPACE" "$NAME" -o jsonpath='{.spec.issuerRef.name}' 2>/dev/null)

    if [[ "$ISSUER" == *"staging"* ]]; then
        ((STAGING_COUNT++))
        ISSUER_TYPE="[STAGING]"
        COLOR="${YELLOW}"
    else
        ((PROD_COUNT++))
        ISSUER_TYPE="[PRODUCTION]"
        COLOR="${GREEN}"
    fi

    if [ "$READY" == "True" ]; then
        echo -e "${COLOR}✓${NC} $NAMESPACE/$NAME - Ready $ISSUER_TYPE"
    else
        echo -e "${RED}✗${NC} $NAMESPACE/$NAME - Not Ready $ISSUER_TYPE"
        ALL_READY=false

        # Show why it's not ready
        echo -e "  ${RED}Reason:${NC}"
        kubectl describe certificate -n "$NAMESPACE" "$NAME" | grep -A 5 "Status:" | tail -n 5 | sed 's/^/  /'
    fi
done <<< "$CERTS"

echo ""
echo -e "${BLUE}============================================${NC}"
echo -e "${BLUE}Summary${NC}"
echo -e "${BLUE}============================================${NC}"
echo ""
echo -e "Staging Certificates:    ${YELLOW}$STAGING_COUNT${NC}"
echo -e "Production Certificates: ${GREEN}$PROD_COUNT${NC}"
echo ""

if [ "$ALL_READY" = true ]; then
    echo -e "${GREEN}✓ All certificates are Ready!${NC}"
    echo ""

    if [ $STAGING_COUNT -gt 0 ]; then
        echo -e "${YELLOW}You are currently using STAGING certificates.${NC}"
        echo -e "${YELLOW}These will show browser security warnings.${NC}"
        echo ""
        echo -e "${BLUE}Next Step: Switch to Production${NC}"
        echo ""
        echo "Once you've verified staging certificates work:"
        echo -e "  ${YELLOW}./scripts/switch-to-prod-certs.sh${NC}"
        echo ""
        echo "This will issue trusted certificates for production use."
    else
        echo -e "${GREEN}You are using PRODUCTION certificates.${NC}"
        echo -e "${GREEN}These are trusted by browsers.${NC}"
        echo ""
        echo "Test your sites:"
        echo "  - https://devops-toolkit.dremer10.com"
        echo "  - https://staging-devops-toolkit.dremer10.com"
        echo "  - https://grafana.devops-toolkit.dremer10.com"
    fi
else
    echo -e "${RED}✗ Some certificates are not ready yet.${NC}"
    echo ""
    echo "Common issues:"
    echo ""
    echo "1. Port forwarding not configured (MOST COMMON):"
    echo -e "   ${YELLOW}Run diagnostics: ./scripts/diagnose-certs.sh${NC}"
    echo -e "   ${YELLOW}If using NodePort, setup forwarding: ssh hostinger 'sudo bash' < ./scripts/setup-port-forwarding.sh${NC}"
    echo ""
    echo "2. DNS not configured:"
    echo -e "   ${YELLOW}Ensure A records point to your VPS IP${NC}"
    echo ""
    echo "3. Firewall blocking port 80:"
    echo -e "   ${YELLOW}Let's Encrypt needs port 80 for HTTP01 challenge${NC}"
    echo ""
    echo "4. Certificate still being issued:"
    echo -e "   ${YELLOW}Wait 2-5 minutes and re-run: ./scripts/check-certs.sh${NC}"
    echo ""
    echo "5. View cert-manager logs:"
    echo -e "   ${YELLOW}kubectl logs -n cert-manager -l app=cert-manager --tail=50 | grep -i error${NC}"
    echo ""
    echo "Re-run this script after fixing issues:"
    echo -e "  ${YELLOW}./scripts/check-certs.sh${NC}"
fi

echo ""
