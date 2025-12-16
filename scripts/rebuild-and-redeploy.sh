#!/bin/bash
set -e

# Rebuild and Redeploy with Environment Colors
# This script ensures the new environment detection code is deployed

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}Rebuild and Redeploy - Environment Colors${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""

# Step 1: Verify source files exist
echo -e "${YELLOW}[1/5] Verifying source files...${NC}"
if [ ! -f "$PROJECT_ROOT/devops-tools-source/src/utils/runtime-env.ts" ]; then
    echo -e "${RED}ERROR: runtime-env.ts not found!${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Source files verified${NC}"
echo ""

# Step 2: Build Docker image
echo -e "${YELLOW}[2/5] Building Docker image...${NC}"
cd "$PROJECT_ROOT"
./scripts/build-and-push.sh
echo ""

# Step 3: Force pull new image on all environments
echo -e "${YELLOW}[3/5] Restarting deployments to pull new image...${NC}"
kubectl rollout restart deployment/devops-toolkit -n production
kubectl rollout restart deployment/devops-toolkit -n staging
kubectl rollout restart deployment/devops-toolkit -n qa
kubectl rollout restart deployment/devops-toolkit -n dev
echo -e "${GREEN}✓ Deployments restarted${NC}"
echo ""

# Step 4: Wait for rollouts
echo -e "${YELLOW}[4/5] Waiting for rollouts to complete...${NC}"
echo "  Production..."
kubectl rollout status deployment/devops-toolkit -n production --timeout=120s
echo "  Staging..."
kubectl rollout status deployment/devops-toolkit -n staging --timeout=120s
echo "  QA..."
kubectl rollout status deployment/devops-toolkit -n qa --timeout=120s
echo "  Dev..."
kubectl rollout status deployment/devops-toolkit -n dev --timeout=120s
echo -e "${GREEN}✓ All rollouts complete${NC}"
echo ""

# Step 5: Show URLs to test
echo -e "${YELLOW}[5/5] Deployment Complete!${NC}"
echo ""
echo -e "${GREEN}Test each environment:${NC}"
echo ""
echo -e "${RED}Production (RED):${NC}    https://devops-toolkit.dremer10.com"
echo -e "${YELLOW}Staging (AMBER):${NC}     https://staging-devops-toolkit.dremer10.com"
echo -e "\033[0;36mQA (CYAN):${NC}           https://qa-devops-toolkit.dremer10.com"
echo -e "${GREEN}Dev (GREEN):${NC}         https://dev-devops-toolkit.dremer10.com"
echo ""
echo -e "${GREEN}What to look for:${NC}"
echo "  1. Colored bar at the top showing environment name"
echo "  2. All buttons and UI elements in environment color"
echo "  3. Environment badge in the sidebar"
echo "  4. Open browser console (F12) and look for:"
echo "     [Environment Detection] { hostname: '...', detected: '...' }"
echo ""
echo -e "${YELLOW}If you still don't see colors:${NC}"
echo "  1. Hard refresh: Ctrl+F5 (Windows) or Cmd+Shift+R (Mac)"
echo "  2. Clear browser cache"
echo "  3. Check browser console for errors"
echo ""
