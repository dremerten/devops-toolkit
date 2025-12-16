#!/bin/bash
set -e

# DevOps Observatory VPS Setup Script
# This script sets up a Hostinger VPS with K3s, Jenkins, Vault, and cert-manager

echo "========================================="
echo "DevOps Observatory VPS Setup"
echo "========================================="
echo ""

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
DOMAIN="${DOMAIN:-devops-toolkit.dremer10.com}"
EMAIL="${EMAIL:-your-email@example.com}"
ENVIRONMENT="${ENVIRONMENT:-production}"

echo -e "${GREEN}Configuration:${NC}"
echo "  Domain: $DOMAIN"
echo "  Email: $EMAIL"
echo "  Environment: $ENVIRONMENT"
echo ""

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}Please run as root (use sudo)${NC}"
  exit 1
fi

echo -e "${YELLOW}Step 1: Update system packages${NC}"
apt-get update
apt-get upgrade -y

echo -e "${YELLOW}Step 2: Install required packages${NC}"
apt-get install -y \
    curl \
    wget \
    git \
    vim \
    htop \
    net-tools \
    ufw \
    fail2ban \
    unzip \
    jq

echo -e "${YELLOW}Step 3: Configure firewall${NC}"
ufw --force reset
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw allow 80/tcp    # HTTP
ufw allow 443/tcp   # HTTPS
ufw allow 6443/tcp  # K3s API
ufw allow 10250/tcp # Kubelet
ufw --force enable

echo -e "${YELLOW}Step 4: Install K3s (control plane + agent)${NC}"
if command -v k3s &> /dev/null; then
    echo "K3s already installed, skipping..."
else
    # Install K3s with embedded etcd for HA capability
    curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server \
        --cluster-init \
        --disable nginx \
        --write-kubeconfig-mode 644" sh -

    # Wait for K3s to be ready
    echo "Waiting for K3s to be ready..."
    until kubectl get nodes &>/dev/null; do
        sleep 2
    done

    echo -e "${GREEN}K3s installed successfully!${NC}"
fi

# Set up kubectl for non-root user
mkdir -p $HOME/.kube
cp /etc/rancher/k3s/k3s.yaml $HOME/.kube/config
chmod 600 $HOME/.kube/config

echo -e "${YELLOW}Step 5: Install Helm${NC}"
if command -v helm &> /dev/null; then
    echo "Helm already installed, skipping..."
else
    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
    echo -e "${GREEN}Helm installed successfully!${NC}"
fi

echo -e "${YELLOW}Step 6: Install nginx as Ingress Controller${NC}"
helm repo add nginx https://nginx.github.io/charts
helm repo update

kubectl create namespace nginx --dry-run=client -o yaml | kubectl apply -f -

helm upgrade --install nginx nginx/nginx \
    --namespace nginx \
    --set ports.web.redirectTo.port=websecure \
    --set ports.websecure.tls.enabled=true \
    --wait

echo -e "${GREEN}nginx installed!${NC}"

echo -e "${YELLOW}Step 7: Install cert-manager${NC}"
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.14.0/cert-manager.yaml

echo "Waiting for cert-manager to be ready..."
kubectl wait --for=condition=ready pod -l app.kubernetes.io/instance=cert-manager -n cert-manager --timeout=300s

echo -e "${GREEN}cert-manager installed!${NC}"

echo -e "${YELLOW}Step 8: Create namespaces${NC}"
kubectl create namespace ci-cd --dry-run=client -o yaml | kubectl apply -f -
kubectl create namespace vault --dry-run=client -o yaml | kubectl apply -f -
kubectl create namespace devops-toolkit --dry-run=client -o yaml | kubectl apply -f -
kubectl create namespace monitoring --dry-run=client -o yaml | kubectl apply -f -

echo -e "${GREEN}Namespaces created!${NC}"

echo ""
echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}VPS Setup Complete!${NC}"
echo -e "${GREEN}=========================================${NC}"
echo ""
echo "Next steps:"
echo "1. Update cert-manager ClusterIssuers with your email:"
echo "   Edit kubernetes/cert-manager/cert-manager-install.yaml"
echo ""
echo "2. Apply Kubernetes manifests:"
echo "   kubectl apply -f kubernetes/cert-manager/cert-manager-install.yaml"
echo "   kubectl apply -f kubernetes/namespaces.yaml"
echo "   kubectl apply -f kubernetes/deployments/vault.yaml"
echo "   kubectl apply -f kubernetes/deployments/jenkins.yaml"
echo ""
echo "3. Initialize Vault:"
echo "   kubectl exec -it vault-0 -n vault -- vault operator init"
echo "   Save the unseal keys and root token!"
echo ""
echo "4. Get Jenkins initial password:"
echo "   kubectl exec -it deployment/jenkins -n ci-cd -- cat /var/jenkins_home/secrets/initialAdminPassword"
echo ""
echo "K3s cluster info:"
kubectl cluster-info
echo ""
echo "Nodes:"
kubectl get nodes
