#!/bin/bash
set -e

# DevOps-Toolkit Multi-Environment Deployment Script
# Deploys the application to Production, Staging, QA, and Dev environments
# Run this from your LOCAL LAPTOP (not on the VPS)

echo "========================================="
echo "DevOps-Toolkit Multi-Environment Deploy"
echo "========================================="
echo ""

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
KUBECONFIG_PATH="${KUBECONFIG:-$HOME/.kube/config-dremer10}"

# Load .env if exists to get Docker username
if [ -f "$PROJECT_ROOT/.env" ]; then
    export $(cat "$PROJECT_ROOT/.env" | grep -v '^#' | grep 'DOCKER_USERNAME' | xargs)
fi

IMAGE_NAME="${IMAGE_NAME:-${DOCKER_USERNAME:-dremer10}/devops-toolkit:latest}"

echo -e "${GREEN}Configuration:${NC}"
echo "  Docker Image: $IMAGE_NAME"
echo "  Project Root: $PROJECT_ROOT"
echo "  Kubeconfig: $KUBECONFIG_PATH"
echo ""

# Check kubectl
if ! command -v kubectl &> /dev/null; then
    echo -e "${RED}kubectl not found. Please run ./scripts/local-setup.sh first${NC}"
    exit 1
fi

# Check kubeconfig exists
if [ ! -f "$KUBECONFIG_PATH" ]; then
    echo -e "${RED}Kubeconfig not found at $KUBECONFIG_PATH${NC}"
    echo ""
    echo "Please sync kubeconfig from your VPS first:"
    echo "  ./scripts/sync-kubeconfig.sh YOUR_VPS_IP"
    exit 1
fi

# Set kubeconfig for this script
export KUBECONFIG="$KUBECONFIG_PATH"

# Check cluster connectivity
if ! kubectl cluster-info &>/dev/null; then
    echo -e "${RED}Cannot connect to Kubernetes cluster.${NC}"
    echo ""
    echo "Please ensure:"
    echo "  1. VPS is running and accessible"
    echo "  2. Kubeconfig is up to date: ./scripts/sync-kubeconfig.sh YOUR_VPS_IP"
    echo "  3. Port 6443 is accessible"
    exit 1
fi

echo -e "${BLUE}Connected to cluster:${NC}"
kubectl cluster-info | head -1

echo ""
echo -e "${YELLOW}[1/5] Applying namespaces...${NC}"
kubectl apply -f "$PROJECT_ROOT/kubernetes/namespaces.yaml"

echo ""
echo -e "${YELLOW}[2/5] Applying cert-manager ClusterIssuer...${NC}"
if [ -f "$PROJECT_ROOT/kubernetes/cert-manager/cert-manager-install.yaml" ]; then
    kubectl apply -f "$PROJECT_ROOT/kubernetes/cert-manager/cert-manager-install.yaml"
    echo -e "${GREEN}ClusterIssuer applied!${NC}"
else
    echo -e "${RED}Warning: cert-manager-install.yaml not found, skipping...${NC}"
fi

echo ""
echo -e "${YELLOW}[3/5] Deploying application to all namespaces...${NC}"

# Function to deploy to a namespace
deploy_to_namespace() {
    local namespace=$1
    local env_name=$2

    echo ""
    echo -e "${BLUE}Deploying to $env_name environment (namespace: $namespace)...${NC}"

    # Apply deployment
    kubectl apply -f "$PROJECT_ROOT/kubernetes/deployments/devops-toolkit.yaml" -n "$namespace"

    # Apply service
    kubectl apply -f "$PROJECT_ROOT/kubernetes/services/devops-toolkit-service.yaml" -n "$namespace"

    # Wait for deployment to be ready
    echo "Waiting for deployment to be ready..."
    kubectl wait --for=condition=available deployment/devops-toolkit -n "$namespace" --timeout=300s

    echo -e "${GREEN}$env_name deployment ready!${NC}"
}

# Deploy to all environments
deploy_to_namespace "production" "Production"
deploy_to_namespace "staging" "Staging"
deploy_to_namespace "qa" "QA"
deploy_to_namespace "dev" "Dev"

echo ""
echo -e "${YELLOW}[4/5] Applying ingress configurations...${NC}"
kubectl apply -f "$PROJECT_ROOT/kubernetes/ingress/devops-toolkit-ingress.yaml"

echo ""
echo -e "${YELLOW}[5/5] Verifying deployments...${NC}"
echo ""
echo -e "${BLUE}Production:${NC}"
kubectl get pods,svc -n production

echo ""
echo -e "${BLUE}Staging:${NC}"
kubectl get pods,svc -n staging

echo ""
echo -e "${BLUE}QA:${NC}"
kubectl get pods,svc -n qa

echo ""
echo -e "${BLUE}Dev:${NC}"
kubectl get pods,svc -n dev

echo ""
echo -e "${BLUE}Ingresses:${NC}"
kubectl get ingress -A

echo ""
echo -e "${BLUE}Certificates (TLS):${NC}"
kubectl get certificates -A

echo ""
echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}Deployment Complete!${NC}"
echo -e "${GREEN}=========================================${NC}"
echo ""
echo -e "${BLUE}Your environments are available at:${NC}"
echo "  - Production: https://devops-toolkit.dremer10.com"
echo "  - Staging:    https://staging-devops-toolkit.dremer10.com"
echo "  - QA:         https://qa-devops-toolkit.dremer10.com"
echo "  - Dev:        https://dev-devops-toolkit.dremer10.com"
echo ""
echo -e "${YELLOW}Note:${NC} TLS certificates may take a few minutes to be issued by Let's Encrypt."
echo "You can check certificate status with:"
echo "  kubectl get certificates -A"
echo "  kubectl describe certificate <cert-name> -n <namespace>"
echo ""
