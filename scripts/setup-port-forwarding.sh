#!/bin/bash
set -e

# Setup Port Forwarding for NodePort Ingress
# Forwards port 80 → 30080 and 443 → 30443

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}============================================${NC}"
echo -e "${BLUE}Port Forwarding Setup for NGINX Ingress${NC}"
echo -e "${BLUE}============================================${NC}"
echo ""

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}This script must be run as root${NC}"
    echo "Please run: sudo bash $0"
    exit 1
fi

echo -e "${YELLOW}This will configure iptables to forward:${NC}"
echo "  Port 80  → NodePort 30080 (HTTP)"
echo "  Port 443 → NodePort 30443 (HTTPS)"
echo ""

read -p "Continue? (yes/no): " -r
if [[ ! $REPLY =~ ^[Yy]es$ ]]; then
    echo "Cancelled."
    exit 0
fi

echo ""
echo -e "${YELLOW}[1/4] Installing iptables-persistent...${NC}"
apt-get update
apt-get install -y iptables-persistent

echo ""
echo -e "${YELLOW}[2/4] Configuring iptables rules...${NC}"

# Forward port 80 to 30080
iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 30080

# Forward port 443 to 30443
iptables -t nat -A PREROUTING -p tcp --dport 443 -j REDIRECT --to-port 30443

echo -e "${GREEN}✓ iptables rules added${NC}"

echo ""
echo -e "${YELLOW}[3/4] Saving iptables rules...${NC}"
iptables-save > /etc/iptables/rules.v4

echo -e "${GREEN}✓ Rules saved (will persist across reboots)${NC}"

echo ""
echo -e "${YELLOW}[4/4] Verifying configuration...${NC}"
echo ""
echo "Current NAT rules:"
iptables -t nat -L PREROUTING -n -v | grep -E "30080|30443"

echo ""
echo -e "${GREEN}============================================${NC}"
echo -e "${GREEN}Port Forwarding Configured!${NC}"
echo -e "${GREEN}============================================${NC}"
echo ""
echo "Traffic flow:"
echo -e "  ${BLUE}Internet:80${NC} → ${GREEN}VPS:80${NC} → ${YELLOW}NodePort:30080${NC} → ${GREEN}NGINX Ingress${NC}"
echo -e "  ${BLUE}Internet:443${NC} → ${GREEN}VPS:443${NC} → ${YELLOW}NodePort:30443${NC} → ${GREEN}NGINX Ingress${NC}"
echo ""
echo "Next steps:"
echo -e "  1. Wait 1-2 minutes for rules to take effect"
echo -e "  2. Test: ${YELLOW}curl -I http://$(hostname -I | awk '{print $1}')${NC}"
echo -e "  3. Check certificates: ${YELLOW}./scripts/check-certs.sh${NC}"
echo ""
