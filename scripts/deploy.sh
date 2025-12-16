#!/bin/bash
set -e

# Main Deployment Script (Run from Local Laptop)
# This is the main entry point for deploying everything

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "========================================="
echo "DevOps-Toolkit Full Deployment"
echo "========================================="
echo ""

# Parse arguments
SKIP_BUILD=false
SKIP_APP=false
SKIP_MONITORING=false

while [[ $# -gt 0 ]]; do
    case $1 in
        --skip-build)
            SKIP_BUILD=true
            shift
            ;;
        --skip-app)
            SKIP_APP=true
            shift
            ;;
        --skip-monitoring)
            SKIP_MONITORING=true
            shift
            ;;
        --help)
            echo "Usage: ./scripts/deploy.sh [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  --skip-build        Skip building and pushing Docker image"
            echo "  --skip-app          Skip deploying application"
            echo "  --skip-monitoring   Skip deploying monitoring stack"
            echo "  --help              Show this help message"
            echo ""
            echo "Examples:"
            echo "  ./scripts/deploy.sh                    # Full deployment"
            echo "  ./scripts/deploy.sh --skip-build       # Deploy without rebuilding image"
            echo "  ./scripts/deploy.sh --skip-monitoring  # Deploy app only"
            exit 0
            ;;
        *)
            echo -e "${RED}Unknown option: $1${NC}"
            echo "Use --help for usage information"
            exit 1
            ;;
    esac
done

echo -e "${BLUE}Deployment Plan:${NC}"
echo "  Build & Push Image: $([ "$SKIP_BUILD" = true ] && echo "❌ Skipped" || echo "✅ Yes")"
echo "  Deploy Application: $([ "$SKIP_APP" = true ] && echo "❌ Skipped" || echo "✅ Yes")"
echo "  Deploy Monitoring:  $([ "$SKIP_MONITORING" = true ] && echo "❌ Skipped" || echo "✅ Yes")"
echo ""

read -p "Continue with deployment? (yes/no): " -r
if [[ ! $REPLY =~ ^[Yy]es$ ]]; then
    echo "Deployment cancelled."
    exit 0
fi

# Step 1: Build and push Docker image
if [ "$SKIP_BUILD" = false ]; then
    echo ""
    echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${YELLOW}Step 1: Building and Pushing Docker Image${NC}"
    echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    "$SCRIPT_DIR/build-and-push.sh"
else
    echo ""
    echo -e "${YELLOW}Skipping build step...${NC}"
fi

# Step 2: Deploy application to all environments
if [ "$SKIP_APP" = false ]; then
    echo ""
    echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${YELLOW}Step 2: Deploying Application${NC}"
    echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    "$SCRIPT_DIR/deploy-all-envs.sh"
else
    echo ""
    echo -e "${YELLOW}Skipping application deployment...${NC}"
fi

# Step 3: Deploy monitoring stack
if [ "$SKIP_MONITORING" = false ]; then
    echo ""
    echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${YELLOW}Step 3: Deploying Monitoring Stack${NC}"
    echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

    # Set kubeconfig
    export KUBECONFIG="${KUBECONFIG:-$HOME/.kube/config-dremer10}"
    PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

    echo "Applying monitoring ConfigMaps..."
    kubectl apply -f "$PROJECT_ROOT/kubernetes/configmaps/"

    echo ""
    echo "Deploying monitoring components..."
    kubectl apply -f "$PROJECT_ROOT/kubernetes/monitoring/"

    echo ""
    echo "Applying Grafana ingress..."
    kubectl apply -f "$PROJECT_ROOT/kubernetes/ingress/grafana-ingress.yaml"

    echo ""
    echo "Checking monitoring pods..."
    kubectl get pods -n monitoring

    echo -e "${GREEN}✓ Monitoring stack deployed!${NC}"
else
    echo ""
    echo -e "${YELLOW}Skipping monitoring deployment...${NC}"
fi

echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}Full Deployment Complete!${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${BLUE}Summary:${NC}"
echo ""

# Set kubeconfig for status checks
export KUBECONFIG="${KUBECONFIG:-$HOME/.kube/config-dremer10}"

if kubectl get ingress -A &>/dev/null; then
    echo "Ingresses:"
    kubectl get ingress -A
    echo ""
fi

if kubectl get certificates -A &>/dev/null; then
    echo "TLS Certificates:"
    kubectl get certificates -A
    echo ""
fi

echo -e "${BLUE}Access your environments:${NC}"
echo "  Production: https://devops-toolkit.dremer10.com"
echo "  Staging:    https://staging-devops-toolkit.dremer10.com"
echo "  QA:         https://qa-devops-toolkit.dremer10.com"
echo "  Dev:        https://dev-devops-toolkit.dremer10.com"
echo "  Grafana:    https://grafana.devops-toolkit.dremer10.com"
echo ""
echo -e "${YELLOW}Note:${NC} TLS certificates may take 2-5 minutes to be issued."
echo "Check status with: kubectl get certificates -A"
echo ""
