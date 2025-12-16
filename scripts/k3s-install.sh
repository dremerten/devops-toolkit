#!/bin/bash
set -e

# DevOps-Toolkit K3s Cluster Setup Script
# This script installs k3s on a single VM and configures the environment
# Target: Ubuntu 22.04 on Hostinger VPS (89.116.212.35)

echo "========================================="
echo "DevOps-Toolkit K3s Installation"
echo "========================================="
echo ""

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check for --yes flag
AUTO_CONFIRM=false
for arg in "$@"; do
    if [ "$arg" = "--yes" ] || [ "$arg" = "-y" ]; then
        AUTO_CONFIRM=true
        break
    fi
done

# Configuration
SERVER_IP="${SERVER_IP:-$(hostname -I | awk '{print $1}')}"
DOMAIN_BASE="dremer10.com"
K3S_VERSION="${K3S_VERSION:-v1.28.5+k3s1}"

# Check if SERVER_IP is provided
if [ -z "$SERVER_IP" ]; then
    echo -e "${RED}ERROR: Could not detect server IP address.${NC}"
    echo "Please provide it as an environment variable:"
    echo "  export SERVER_IP=your.server.ip.address"
    echo "  sudo -E bash k3s-install.sh"
    exit 1
fi

# Check if EMAIL is provided
if [ -z "$EMAIL" ]; then
    echo -e "${RED}ERROR: EMAIL is not set.${NC}"
    echo "Please provide it as an environment variable:"
    echo "  export EMAIL=your-email@example.com"
    echo "  sudo -E bash k3s-install.sh"
    exit 1
fi

echo -e "${GREEN}Configuration:${NC}"
echo "  Server IP: $SERVER_IP"
echo "  Domain: $DOMAIN_BASE"
echo "  Email: $EMAIL"
echo "  K3s Version: $K3S_VERSION"
echo ""
echo -e "${BLUE}Environments to be deployed:${NC}"
echo "  - Production: devops-toolkit.${DOMAIN_BASE}"
echo "  - Staging: staging-devops-toolkit.${DOMAIN_BASE}"
echo "  - QA: qa-devops-toolkit.${DOMAIN_BASE}"
echo "  - Dev: dev-devops-toolkit.${DOMAIN_BASE}"
echo ""

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}Please run as root (use sudo)${NC}"
  exit 1
fi

# Confirmation prompt
if [ "$AUTO_CONFIRM" = false ]; then
    read -p "Continue with installation? (yes/no): " -r
    if [[ ! $REPLY =~ ^[Yy]es$ ]]; then
        echo "Installation cancelled."
        exit 0
    fi
else
    echo "Auto-confirming installation (--yes flag provided)..."
fi

echo ""
echo -e "${YELLOW}[1/10] Updating system packages...${NC}"
apt-get update
apt-get upgrade -y

echo ""
echo -e "${YELLOW}[2/10] Installing required packages...${NC}"
apt-get install -y \
    curl \
    wget \
    git \
    vim \
    htop \
    net-tools \
    unzip \
    jq \
    gnupg \
    lsb-release \
    ca-certificates \
    apt-transport-https

echo ""
echo -e "${YELLOW}[3/10] Disabling local firewalls (managed via Hostinger web UI)...${NC}"

# Disable UFW if present
if command -v ufw &> /dev/null; then
    echo -e "${BLUE}Disabling UFW...${NC}"
    ufw --force disable
    systemctl stop ufw 2>/dev/null || true
    systemctl disable ufw 2>/dev/null || true
    echo -e "${GREEN}✓ UFW disabled${NC}"
fi

# Disable firewalld if present
if command -v firewall-cmd &> /dev/null; then
    echo -e "${BLUE}Disabling firewalld...${NC}"
    systemctl stop firewalld 2>/dev/null || true
    systemctl disable firewalld 2>/dev/null || true
    echo -e "${GREEN}✓ firewalld disabled${NC}"
fi

echo -e "${GREEN}Local firewalls disabled! Firewall rules managed via Hostinger web UI.${NC}"

echo ""
echo -e "${YELLOW}[4/10] Installing Docker (for local builds)...${NC}"
if command -v docker &> /dev/null; then
    echo "Docker already installed, skipping..."
else
    # Add Docker's official GPG key
    install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    chmod a+r /etc/apt/keyrings/docker.gpg

    # Set up Docker repository
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

    # Install Docker Engine
    apt-get update
    apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    # Add current user to docker group
    if [ ! -z "$SUDO_USER" ]; then
        usermod -aG docker $SUDO_USER
        echo -e "${GREEN}User $SUDO_USER added to docker group${NC}"
    fi

    echo -e "${GREEN}Docker installed successfully!${NC}"
fi

echo ""
echo -e "${YELLOW}[5/10] Installing K3s (single-node cluster)...${NC}"
if command -v k3s &> /dev/null; then
    echo "K3s already installed, skipping..."
else
    # Install K3s in server mode (combines control-plane and worker)
    # Disable built-in nginx - we'll use NGINX Ingress Controller instead
    curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION="$K3S_VERSION" sh -s - server \
        --disable nginx \
        --write-kubeconfig-mode 644 \
        --node-ip $SERVER_IP \
        --node-external-ip $SERVER_IP \
        --tls-san $SERVER_IP

    # Wait for K3s to be ready
    echo "Waiting for K3s to be ready..."
    sleep 10
    until kubectl get nodes &>/dev/null; do
        echo "Waiting for kubectl..."
        sleep 3
    done

    # Wait for node to be ready
    kubectl wait --for=condition=Ready node --all --timeout=300s

    echo -e "${GREEN}K3s installed successfully!${NC}"
fi

# Set up kubeconfig for non-root user
if [ ! -z "$SUDO_USER" ]; then
    SUDO_HOME=$(eval echo ~$SUDO_USER)
    mkdir -p $SUDO_HOME/.kube
    cp /etc/rancher/k3s/k3s.yaml $SUDO_HOME/.kube/config
    chown -R $SUDO_USER:$SUDO_USER $SUDO_HOME/.kube
    chmod 600 $SUDO_HOME/.kube/config
    echo -e "${GREEN}Kubeconfig configured for user $SUDO_USER${NC}"
fi

# Also set up for root
mkdir -p $HOME/.kube
cp /etc/rancher/k3s/k3s.yaml $HOME/.kube/config
chmod 600 $HOME/.kube/config

echo ""
echo -e "${YELLOW}[6/10] Installing Helm package manager...${NC}"
if command -v helm &> /dev/null; then
    echo "Helm already installed, skipping..."
else
    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
    echo -e "${GREEN}Helm installed successfully!${NC}"
fi

echo ""
echo -e "${YELLOW}[7/10] Installing NGINX Ingress Controller...${NC}"
echo -e "${BLUE}Note: Using NodePort for external load balancer integration${NC}"

# Install NGINX Ingress Controller using the official manifest
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.10.0/deploy/static/provider/baremetal/deploy.yaml

# Wait for NGINX Ingress Controller to be ready
echo "Waiting for NGINX Ingress Controller pods to be created..."
sleep 10

# Wait for the pods to exist first
until kubectl get pods -n ingress-nginx -l app.kubernetes.io/component=controller 2>/dev/null | grep -q ingress-nginx-controller; do
    echo "Waiting for controller pod to be created..."
    sleep 3
done

echo "Controller pod created, waiting for it to be ready..."
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=300s

# Patch the service to use NodePort on specific ports
# This allows external load balancers to route traffic to k3s
kubectl patch svc ingress-nginx-controller -n ingress-nginx -p '{
  "spec": {
    "type": "NodePort",
    "ports": [
      {
        "name": "http",
        "port": 80,
        "protocol": "TCP",
        "targetPort": "http",
        "nodePort": 30080
      },
      {
        "name": "https",
        "port": 443,
        "protocol": "TCP",
        "targetPort": "https",
        "nodePort": 30443
      }
    ]
  }
}'

echo -e "${GREEN}NGINX Ingress Controller installed on NodePorts!${NC}"
echo -e "${BLUE}HTTP available at: localhost:30080${NC}"
echo -e "${BLUE}HTTPS available at: localhost:30443${NC}"

echo ""
echo -e "${YELLOW}[8/10] Installing cert-manager for TLS...${NC}"
# Check if cert-manager is already installed
if kubectl get namespace cert-manager &>/dev/null; then
    echo "cert-manager namespace exists, skipping installation..."
else
    kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.14.4/cert-manager.yaml

    echo "Waiting for cert-manager to be ready..."
    kubectl wait --for=condition=available deployment --all -n cert-manager --timeout=300s

    echo -e "${GREEN}cert-manager installed!${NC}"
fi

echo ""
echo -e "${YELLOW}[9/10] Creating Kubernetes namespaces...${NC}"
kubectl create namespace production --dry-run=client -o yaml | kubectl apply -f -
kubectl create namespace staging --dry-run=client -o yaml | kubectl apply -f -
kubectl create namespace qa --dry-run=client -o yaml | kubectl apply -f -
kubectl create namespace dev --dry-run=client -o yaml | kubectl apply -f -
kubectl create namespace monitoring --dry-run=client -o yaml | kubectl apply -f -
kubectl create namespace ci-cd --dry-run=client -o yaml | kubectl apply -f -

echo -e "${GREEN}All namespaces created!${NC}"

echo ""
echo -e "${YELLOW}[10/10] Verifying installation...${NC}"
echo ""
echo "K3s Cluster Info:"
kubectl cluster-info

echo ""
echo "Nodes:"
kubectl get nodes -o wide

echo ""
echo "Namespaces:"
kubectl get namespaces

echo ""
echo "NGINX Ingress Controller Status:"
kubectl get pods -n ingress-nginx

echo ""
echo "cert-manager Status:"
kubectl get pods -n cert-manager

echo ""
echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}K3s Installation Complete!${NC}"
echo -e "${GREEN}=========================================${NC}"
echo ""
echo -e "${BLUE}Next Steps:${NC}"
echo ""
echo "1. Configure DNS A records to point to $SERVER_IP:"
echo "   - devops-toolkit.${DOMAIN_BASE}"
echo "   - staging-devops-toolkit.${DOMAIN_BASE}"
echo "   - qa-devops-toolkit.${DOMAIN_BASE}"
echo "   - dev-devops-toolkit.${DOMAIN_BASE}"
echo "   - grafana.${DOMAIN_BASE}"
echo ""
echo "2. Create .env file with your Docker Hub credentials:"
echo "   cd /path/to/DevOps-Toolkit"
echo "   cp .env.example .env"
echo "   # Edit .env with your credentials"
echo ""
echo "3. Build and push Docker image:"
echo "   cd /path/to/DevOps-Toolkit"
echo "   docker build -t dremer10/devops-toolkit:latest devops-tools-source/"
echo "   docker login"
echo "   docker push dremer10/devops-toolkit:latest"
echo ""
echo "4. Deploy cert-manager ClusterIssuer:"
echo "   # Update email in kubernetes/cert-manager/cert-manager-install.yaml"
echo "   kubectl apply -f kubernetes/cert-manager/cert-manager-install.yaml"
echo ""
echo "5. Deploy the application to all environments:"
echo "   ./scripts/deploy-all-envs.sh"
echo ""
echo "6. Deploy monitoring stack:"
echo "   kubectl apply -f kubernetes/configmaps/"
echo "   kubectl apply -f kubernetes/monitoring/"
echo ""
echo -e "${YELLOW}Save your kubeconfig:${NC}"
echo "  ~/.kube/config"
echo ""
