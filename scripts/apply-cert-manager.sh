#!/bin/bash
set -e

# Apply cert-manager ClusterIssuers with EMAIL substitution
# This script reads EMAIL from .env and applies the cert-manager configuration

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Get script directory and project root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
ENV_FILE="$PROJECT_ROOT/.env"

echo -e "${BLUE}=====================================${NC}"
echo -e "${BLUE}cert-manager ClusterIssuer Setup${NC}"
echo -e "${BLUE}=====================================${NC}"
echo ""

# Load environment variables from .env file
if [ -f "$ENV_FILE" ]; then
    echo -e "${BLUE}Loading configuration from .env file...${NC}"
    set -a
    source "$ENV_FILE"
    set +a
else
    echo -e "${RED}Error: .env file not found at $ENV_FILE${NC}"
    echo ""
    echo "Please create .env file:"
    echo "  cp .env.example .env"
    echo "  # Edit .env and set EMAIL variable"
    exit 1
fi

# Validate EMAIL is set
if [ -z "$EMAIL" ]; then
    echo -e "${RED}Error: EMAIL is not set in .env file${NC}"
    echo ""
    echo "Please add EMAIL to your .env file:"
    echo "  EMAIL=your-email@example.com"
    exit 1
fi

echo -e "${GREEN}Configuration:${NC}"
echo "  Email: $EMAIL"
echo ""

# Apply cert-manager ClusterIssuers with environment variable substitution
echo -e "${YELLOW}Applying ClusterIssuers (staging and production)...${NC}"

# Use envsubst to replace ${EMAIL} with actual value
envsubst < "$PROJECT_ROOT/kubernetes/cert-manager/cert-manager-install.yaml" | kubectl apply -f -

echo ""
echo -e "${GREEN}=====================================${NC}"
echo -e "${GREEN}ClusterIssuers Applied Successfully!${NC}"
echo -e "${GREEN}=====================================${NC}"
echo ""
echo -e "${BLUE}Next Steps:${NC}"
echo ""
echo "1. Deploy your applications (this creates ingresses and triggers cert requests):"
echo -e "   ${YELLOW}./scripts/deploy-all-envs.sh${NC}"
echo ""
echo "2. Wait 2-5 minutes, then check certificate status across ALL environments:"
echo -e "   ${YELLOW}./scripts/check-certs.sh${NC}"
echo ""
echo "3. Once check-certs.sh shows all certificates as Ready, switch to production:"
echo -e "   ${YELLOW}./scripts/switch-to-prod-certs.sh${NC}"
echo ""
echo -e "${YELLOW}Note: Staging certificates will show browser warnings (untrusted).${NC}"
echo -e "${YELLOW}This is expected! They verify the process works before using production.${NC}"
echo ""
