#!/bin/bash
set -e

# Local Laptop Setup Script
# Prepares your local machine to manage the remote k3s cluster

echo "========================================="
echo "DevOps-Toolkit Local Setup"
echo "========================================="
echo ""

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}This script will install tools needed to manage your remote k3s cluster:${NC}"
echo "  - kubectl (Kubernetes CLI)"
echo "  - helm (Kubernetes package manager)"
echo "  - Docker (for building images)"
echo ""

# Detect OS
OS="$(uname -s)"
case "${OS}" in
    Linux*)     MACHINE=Linux;;
    Darwin*)    MACHINE=Mac;;
    *)          MACHINE="UNKNOWN:${OS}"
esac

echo -e "${GREEN}Detected OS: $MACHINE${NC}"
echo ""

# Check if running on supported OS
if [[ "$MACHINE" != "Linux" && "$MACHINE" != "Mac" ]]; then
    echo -e "${RED}Unsupported OS. This script supports Linux and macOS only.${NC}"
    exit 1
fi

echo -e "${YELLOW}[1/4] Checking/Installing kubectl...${NC}"
if command -v kubectl &> /dev/null; then
    KUBECTL_VERSION=$(kubectl version --client -o json 2>/dev/null | jq -r '.clientVersion.gitVersion' || kubectl version --client --short 2>/dev/null | awk '{print $3}')
    echo -e "${GREEN}kubectl already installed: $KUBECTL_VERSION${NC}"
else
    echo "Installing kubectl..."
    if [[ "$MACHINE" == "Mac" ]]; then
        # macOS installation
        if command -v brew &> /dev/null; then
            brew install kubectl
        else
            echo -e "${YELLOW}Homebrew not found. Installing kubectl manually...${NC}"
            curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/darwin/amd64/kubectl"
            chmod +x kubectl
            sudo mv kubectl /usr/local/bin/
        fi
    else
        # Linux installation
        curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
        chmod +x kubectl
        sudo mv kubectl /usr/local/bin/
    fi
    echo -e "${GREEN}kubectl installed successfully!${NC}"
fi

echo ""
echo -e "${YELLOW}[2/4] Checking/Installing helm...${NC}"
if command -v helm &> /dev/null; then
    HELM_VERSION=$(helm version --short 2>/dev/null | awk '{print $1}' || helm version --template='{{.Version}}')
    echo -e "${GREEN}helm already installed: $HELM_VERSION${NC}"
else
    echo "Installing helm..."
    if [[ "$MACHINE" == "Mac" ]]; then
        if command -v brew &> /dev/null; then
            brew install helm
        else
            curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
        fi
    else
        curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
    fi
    echo -e "${GREEN}helm installed successfully!${NC}"
fi

echo ""
echo -e "${YELLOW}[3/4] Checking Docker installation...${NC}"
if command -v docker &> /dev/null; then
    DOCKER_VERSION=$(docker --version | awk '{print $3}' | tr -d ',')
    echo -e "${GREEN}Docker already installed: $DOCKER_VERSION${NC}"

    # Check if Docker daemon is running
    if ! docker ps &> /dev/null; then
        echo -e "${YELLOW}Warning: Docker daemon is not running. Please start Docker Desktop.${NC}"
    fi
else
    echo -e "${YELLOW}Docker not found!${NC}"
    echo ""
    echo "Please install Docker Desktop for your OS:"
    if [[ "$MACHINE" == "Mac" ]]; then
        echo "  macOS: https://docs.docker.com/desktop/install/mac-install/"
    else
        echo "  Linux: https://docs.docker.com/desktop/install/linux-install/"
    fi
    echo ""
    echo "After installing Docker, run this script again."
    exit 1
fi

echo ""
echo -e "${YELLOW}[4/4] Setting up project environment...${NC}"

# Create .kube directory if it doesn't exist
mkdir -p ~/.kube

# Check if .env exists
if [ ! -f .env ]; then
    echo -e "${YELLOW}.env file not found. Creating from template...${NC}"
    if [ -f .env.example ]; then
        cp .env.example .env
        echo -e "${GREEN}.env file created!${NC}"
        echo -e "${YELLOW}Please edit .env with your Docker Hub credentials:${NC}"
        echo "  vim .env"
        echo "  # or"
        echo "  nano .env"
    else
        echo -e "${RED}Warning: .env.example not found${NC}"
    fi
else
    echo -e "${GREEN}.env file already exists${NC}"
fi

# Check for kubeconfig
if [ -f ~/.kube/config-dremer10 ]; then
    echo -e "${GREEN}kubeconfig for dremer10 cluster found${NC}"

    # Test connection
    if kubectl --kubeconfig ~/.kube/config-dremer10 cluster-info &>/dev/null; then
        echo -e "${GREEN}Successfully connected to remote cluster!${NC}"
    else
        echo -e "${YELLOW}kubeconfig exists but cannot connect to cluster${NC}"
        echo "You may need to update the server IP or fetch a new kubeconfig"
    fi
else
    echo -e "${YELLOW}kubeconfig not found. You'll need to fetch it from your VPS.${NC}"
    echo "After setting up k3s on your VPS, run:"
    echo "  ./scripts/sync-kubeconfig.sh YOUR_VPS_IP"
fi

echo ""
echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}Local Setup Complete!${NC}"
echo -e "${GREEN}=========================================${NC}"
echo ""
echo -e "${BLUE}Next Steps:${NC}"
echo ""
echo "1. If you haven't set up the VPS yet:"
echo -e "   ${YELLOW}./scripts/remote-init.sh YOUR_VPS_IP${NC}"
echo ""
echo "2. Sync kubeconfig from VPS:"
echo -e "   ${YELLOW}./scripts/sync-kubeconfig.sh YOUR_VPS_IP${NC}"
echo ""
echo "3. Build and push Docker image:"
echo -e "   ${YELLOW}./scripts/build-and-push.sh${NC}"
echo ""
echo "4. Deploy to all environments:"
echo -e "   ${YELLOW}./scripts/deploy.sh${NC}"
echo ""
echo -e "${BLUE}Verify installation:${NC}"
echo "  kubectl version --client"
echo "  helm version"
echo "  docker --version"
echo ""
