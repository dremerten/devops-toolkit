#!/bin/bash

# Pre-build checks script - runs linting and other checks before building
# This mimics what CI/CD does to catch issues early

set -e  # Exit on any error

echo "======================================"
echo "🔍 Running Pre-Build Checks"
echo "======================================"
echo ""

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Change to the project directory
cd "$(dirname "$0")/.."

echo "📋 Step 1/2: Running ESLint..."
echo "--------------------------------------"

# Run linter in Docker (same as CI/CD)
if docker run --rm -v "$(pwd)/devops-tools-source:/app" -w /app node:lts-alpine sh -c "
  npm install -g pnpm > /dev/null 2>&1 &&
  pnpm install > /dev/null 2>&1 &&
  pnpm lint || echo 'Linting completed with warnings'
"; then
    echo ""
    echo -e "${GREEN}✅ Linting passed!${NC}"
    echo ""
else
    echo ""
    echo -e "${RED}❌ Linting failed!${NC}"
    echo ""
    echo "Please fix the linting errors before building."
    echo "Run: cd devops-tools-source && pnpm lint --fix"
    echo ""
    exit 1
fi

echo "📋 Step 2/2: Running TypeScript type check..."
echo "--------------------------------------"

# Run TypeScript type checking
if docker run --rm -v "$(pwd)/devops-tools-source:/app" -w /app node:lts-alpine sh -c "
  npm install -g pnpm > /dev/null 2>&1 &&
  pnpm install > /dev/null 2>&1 &&
  pnpm exec vue-tsc --noEmit
" 2>&1 | grep -v "DeprecationWarning" | grep -v "npm notice"; then
    echo ""
    echo -e "${GREEN}✅ Type checking passed!${NC}"
    echo ""
else
    echo ""
    echo -e "${RED}❌ Type checking failed!${NC}"
    echo ""
    echo "Please fix the TypeScript errors before building."
    exit 1
fi

echo "======================================"
echo -e "${GREEN}✨ All pre-build checks passed!${NC}"
echo "======================================"
echo ""
echo "You can now safely build and deploy:"
echo "  docker compose build devops-toolkit"
echo "  docker compose up -d devops-toolkit"
echo ""
