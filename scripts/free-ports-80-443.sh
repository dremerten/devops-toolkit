#!/bin/bash
set -e

# Find and stop services using ports 80/443

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

SSH_HOST="${1:-hostinger}"

echo -e "${BLUE}============================================${NC}"
echo -e "${BLUE}Free Ports 80 and 443${NC}"
echo -e "${BLUE}============================================${NC}"
echo ""

echo -e "${YELLOW}[1/3] Checking what's using ports 80 and 443...${NC}"
echo ""

ssh "$SSH_HOST" bash << 'ENDSSH'
set -e

echo "Processes using port 80:"
if lsof -i :80 2>/dev/null || netstat -tulpen | grep ':80 '; then
    echo ""
else
    echo "  (none)"
fi

echo ""
echo "Processes using port 443:"
if lsof -i :443 2>/dev/null || netstat -tulpen | grep ':443 '; then
    echo ""
else
    echo "  (none)"
fi

echo ""
echo "All Docker containers:"
docker ps -a --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"

ENDSSH

echo ""
echo -e "${YELLOW}[2/3] Stopping all services using ports 80/443...${NC}"
echo ""

ssh "$SSH_HOST" bash << 'ENDSSH'
set -e

# Stop Traefik if running
if docker ps | grep -q traefik; then
    echo "Stopping Traefik..."
    docker stop root-traefik-1 || true
    echo "✓ Traefik stopped"
fi

# Remove any docker containers using ports 80/443
CONTAINERS=$(docker ps -q --filter "publish=80" --filter "publish=443")
if [ ! -z "$CONTAINERS" ]; then
    echo "Stopping Docker containers using ports 80/443..."
    docker stop $CONTAINERS
    echo "✓ Containers stopped"
fi

# Kill any other processes using port 80
PORT_80_PIDS=$(lsof -t -i:80 2>/dev/null || true)
if [ ! -z "$PORT_80_PIDS" ]; then
    echo "Killing processes using port 80: $PORT_80_PIDS"
    kill -9 $PORT_80_PIDS || true
fi

# Kill any other processes using port 443
PORT_443_PIDS=$(lsof -t -i:443 2>/dev/null || true)
if [ ! -z "$PORT_443_PIDS" ]; then
    echo "Killing processes using port 443: $PORT_443_PIDS"
    kill -9 $PORT_443_PIDS || true
fi

sleep 3

echo ""
echo "✓ Ports should now be free"
ENDSSH

echo -e "${GREEN}✓ Cleanup complete${NC}"

echo ""
echo -e "${YELLOW}[3/3] Verifying ports are free...${NC}"
echo ""

ssh "$SSH_HOST" bash << 'ENDSSH'
set -e

echo "Checking port 80:"
if lsof -i :80 2>/dev/null || netstat -tulpen | grep ':80 ' | grep LISTEN; then
    echo "⚠ Port 80 still in use!"
    exit 1
else
    echo "✓ Port 80 is free"
fi

echo ""
echo "Checking port 443:"
if lsof -i :443 2>/dev/null || netstat -tulpen | grep ':443 ' | grep LISTEN; then
    echo "⚠ Port 443 still in use!"
    exit 1
else
    echo "✓ Port 443 is free"
fi
ENDSSH

echo ""
echo -e "${GREEN}============================================${NC}"
echo -e "${GREEN}Ports 80 and 443 are now free!${NC}"
echo -e "${GREEN}============================================${NC}"
echo ""

echo -e "${BLUE}Next step:${NC}"
echo -e "  ${YELLOW}./scripts/fix-nginx-ingress-ports.sh${NC}"
echo ""
