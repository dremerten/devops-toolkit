#!/bin/bash

# Diagnose Certificate Issues
# Checks DNS, firewall, and HTTP01 challenge setup

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}============================================${NC}"
echo -e "${BLUE}Certificate Troubleshooting Diagnostics${NC}"
echo -e "${BLUE}============================================${NC}"
echo ""

# Get VPS IP
echo -e "${YELLOW}Detecting VPS IP...${NC}"
VPS_IP=$(ssh hostinger "curl -4 -s ifconfig.me 2>/dev/null" 2>/dev/null)
if [ -z "$VPS_IP" ]; then
    echo -e "${RED}Failed to detect VPS IP via SSH${NC}"
    read -p "Enter your VPS IP manually: " VPS_IP
fi
echo -e "${GREEN}VPS IP: $VPS_IP${NC}"
echo ""

# List of domains to check
DOMAINS=(
    "devops-toolkit.dremer10.com"
    "staging-devops-toolkit.dremer10.com"
    "qa-devops-toolkit.dremer10.com"
    "dev-devops-toolkit.dremer10.com"
    "grafana.devops-toolkit.dremer10.com"
    "n8n.dremer10.com"
)

echo -e "${BLUE}[1/3] Checking DNS Configuration${NC}"
echo "================================================"
echo ""

DNS_OK=true
for domain in "${DOMAINS[@]}"; do
    echo -e "${YELLOW}Checking: $domain${NC}"

    # Get DNS A record
    RESOLVED_IP=$(dig +short "$domain" @8.8.8.8 | tail -n1)

    if [ -z "$RESOLVED_IP" ]; then
        echo -e "${RED}  ✗ No A record found${NC}"
        echo -e "    ${YELLOW}Action: Add A record pointing to $VPS_IP${NC}"
        DNS_OK=false
    elif [ "$RESOLVED_IP" != "$VPS_IP" ]; then
        echo -e "${RED}  ✗ Points to wrong IP: $RESOLVED_IP (expected: $VPS_IP)${NC}"
        echo -e "    ${YELLOW}Action: Update A record to point to $VPS_IP${NC}"
        DNS_OK=false
    else
        echo -e "${GREEN}  ✓ Correctly points to $VPS_IP${NC}"
    fi
    echo ""
done

echo ""
echo -e "${BLUE}[2/3] Checking Port 80 Accessibility${NC}"
echo "================================================"
echo ""

# Check if port 80 is open
echo -e "${YELLOW}Testing HTTP access to VPS...${NC}"
if timeout 5 curl -s -o /dev/null -w "%{http_code}" "http://$VPS_IP" >/dev/null 2>&1; then
    HTTP_CODE=$(timeout 5 curl -s -o /dev/null -w "%{http_code}" "http://$VPS_IP")
    if [ "$HTTP_CODE" == "000" ]; then
        echo -e "${RED}✗ Port 80 is blocked or not responding${NC}"
        echo -e "  ${YELLOW}Action: Open port 80 in Hostinger firewall${NC}"
        echo -e "  ${YELLOW}Source: 0.0.0.0/0 (must be public for Let's Encrypt)${NC}"
    else
        echo -e "${GREEN}✓ Port 80 is accessible (HTTP $HTTP_CODE)${NC}"
    fi
else
    echo -e "${RED}✗ Connection to port 80 timed out${NC}"
    echo -e "  ${YELLOW}Action: Open port 80 in Hostinger firewall${NC}"
fi

echo ""
echo -e "${YELLOW}Testing HTTPS access to VPS...${NC}"
if timeout 5 curl -s -k -o /dev/null -w "%{http_code}" "https://$VPS_IP" >/dev/null 2>&1; then
    HTTPS_CODE=$(timeout 5 curl -s -k -o /dev/null -w "%{http_code}" "https://$VPS_IP")
    if [ "$HTTPS_CODE" == "000" ]; then
        echo -e "${RED}✗ Port 443 is blocked or not responding${NC}"
        echo -e "  ${YELLOW}Action: Open port 443 in Hostinger firewall${NC}"
    else
        echo -e "${GREEN}✓ Port 443 is accessible (HTTPS $HTTPS_CODE)${NC}"
    fi
else
    echo -e "${YELLOW}⚠ Port 443 not responding (this is OK if not configured yet)${NC}"
fi

echo ""
echo -e "${BLUE}[3/3] Checking NGINX Ingress Controller${NC}"
echo "================================================"
echo ""

# Auto-detect kubeconfig if not set
if [ -z "$KUBECONFIG" ] && [ -f "$HOME/.kube/config-dremer10" ]; then
    export KUBECONFIG="$HOME/.kube/config-dremer10"
fi

if kubectl cluster-info &>/dev/null; then
    echo -e "${YELLOW}Checking NGINX Ingress Controller status...${NC}"

    NGINX_PODS=$(kubectl get pods -n ingress-nginx -l app.kubernetes.io/component=controller --no-headers 2>/dev/null)
    if [ -z "$NGINX_PODS" ]; then
        echo -e "${RED}✗ NGINX Ingress Controller pods not found${NC}"
        echo -e "  ${YELLOW}Action: Reinstall NGINX Ingress Controller${NC}"
    else
        RUNNING=$(echo "$NGINX_PODS" | grep "Running" | wc -l)
        TOTAL=$(echo "$NGINX_PODS" | wc -l)

        if [ "$RUNNING" -eq "$TOTAL" ]; then
            echo -e "${GREEN}✓ NGINX Ingress Controller running ($RUNNING/$TOTAL pods)${NC}"
            echo ""
            kubectl get pods -n ingress-nginx -l app.kubernetes.io/component=controller
        else
            echo -e "${RED}✗ Some NGINX pods not running ($RUNNING/$TOTAL)${NC}"
            kubectl get pods -n ingress-nginx -l app.kubernetes.io/component=controller
        fi
    fi

    echo ""
    echo -e "${YELLOW}Checking NGINX Ingress Service...${NC}"
    kubectl get svc -n ingress-nginx ingress-nginx-controller

    echo ""
    echo -e "${YELLOW}Checking HTTP01 Challenge Solver Pods...${NC}"
    SOLVER_PODS=$(kubectl get pods -A | grep "cm-acme-http-solver" | wc -l)
    if [ "$SOLVER_PODS" -gt 0 ]; then
        echo -e "${GREEN}Found $SOLVER_PODS HTTP01 solver pods${NC}"
        kubectl get pods -A | grep "cm-acme-http-solver"
    else
        echo -e "${YELLOW}No HTTP01 solver pods found (this is normal if challenges completed)${NC}"
    fi
else
    echo -e "${YELLOW}⚠ Cannot connect to cluster - skipping Kubernetes checks${NC}"
    echo -e "  ${YELLOW}Run: make sync VPS_IP=hostinger${NC}"
fi

echo ""
echo -e "${BLUE}============================================${NC}"
echo -e "${BLUE}Required Firewall Configuration${NC}"
echo -e "${BLUE}============================================${NC}"
echo ""
echo "Open these ports in Hostinger VPS firewall:"
echo ""
echo -e "${GREEN}Port 80${NC}   - TCP - Source: ${YELLOW}0.0.0.0/0${NC} - HTTP (Required for Let's Encrypt)"
echo -e "${GREEN}Port 443${NC}  - TCP - Source: ${YELLOW}0.0.0.0/0${NC} - HTTPS (For your websites)"
echo -e "${GREEN}Port 6443${NC} - TCP - Source: ${YELLOW}$(curl -4 -s ifconfig.me)/32${NC} - Kubernetes API (Your IP only)"
echo ""
echo -e "${YELLOW}Important: Port 80 MUST be open to the public (0.0.0.0/0)${NC}"
echo -e "${YELLOW}Let's Encrypt servers need to access /.well-known/acme-challenge/${NC}"
echo ""

echo -e "${BLUE}============================================${NC}"
echo -e "${BLUE}DNS Configuration Required${NC}"
echo -e "${BLUE}============================================${NC}"
echo ""
echo "Add these A records in Squarespace DNS:"
echo ""
for domain in "${DOMAINS[@]}"; do
    echo -e "${YELLOW}$domain${NC} → ${GREEN}$VPS_IP${NC}"
done
echo ""
echo "DNS propagation can take 5-60 minutes."
echo ""

if [ "$DNS_OK" = true ]; then
    echo -e "${GREEN}✓ DNS configuration looks good!${NC}"
    echo ""
    echo "Next step: Wait for certificates to be issued (2-5 minutes)"
    echo -e "  ${YELLOW}./scripts/check-certs.sh${NC}"
else
    echo -e "${RED}✗ Fix DNS configuration first${NC}"
    echo ""
    echo "After updating DNS, wait 5-10 minutes for propagation, then:"
    echo -e "  ${YELLOW}./scripts/diagnose-certs.sh${NC} - Re-run diagnostics"
    echo -e "  ${YELLOW}./scripts/check-certs.sh${NC} - Check certificate status"
fi

echo ""
