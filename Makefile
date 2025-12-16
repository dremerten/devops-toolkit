.PHONY: help setup init sync build push deploy deploy-app deploy-monitoring status logs clean

# Load environment variables from .env file if it exists
-include .env
export

# Default target
help:
	@echo "DevOps-Toolkit Management Commands"
	@echo "======================================"
	@echo ""
	@echo "Setup Commands:"
	@echo "  make setup              - Set up local laptop with required tools"
	@echo "  make init VPS_IP=<host> - Initialize k3s on remote VPS"
	@echo "  make sync VPS_IP=<host> - Sync kubeconfig from VPS to local"
	@echo ""
	@echo "  Note: VPS_IP can be an SSH alias (e.g., 'hostinger') or IP address"
	@echo ""
	@echo "Build & Deploy:"
	@echo "  make build              - Build and push Docker image"
	@echo "  make deploy             - Full deployment (build + app + monitoring)"
	@echo "  make deploy-app         - Deploy application only (skip build)"
	@echo "  make deploy-monitoring  - Deploy monitoring stack only"
	@echo ""
	@echo "Status & Monitoring:"
	@echo "  make status             - Show cluster status"
	@echo "  make pods               - Show all pods"
	@echo "  make ingress            - Show all ingresses"
	@echo "  make certs              - Show TLS certificates status"
	@echo "  make logs ENV=<env>     - Show logs for environment (prod/staging/qa/dev)"
	@echo ""
	@echo "Development:"
	@echo "  make local              - Start local development environment"
	@echo "  make local-down         - Stop local development environment"
	@echo ""
	@echo "Utilities:"
	@echo "  make clean              - Clean up local Docker images"
	@echo ""
	@echo "Examples:"
	@echo "  make init VPS_IP=hostinger"
	@echo "  make init VPS_IP=192.168.1.100"
	@echo "  make sync VPS_IP=hostinger"
	@echo "  make deploy"
	@echo "  make logs ENV=production"
	@echo ""

# Setup local environment
setup:
	@./scripts/local-setup.sh

# Initialize remote VPS
init:
ifndef VPS_IP
	@echo "Error: VPS_IP is required"
	@echo "Usage: make init VPS_IP=<host>"
	@echo ""
	@echo "Examples:"
	@echo "  make init VPS_IP=hostinger"
	@echo "  make init VPS_IP=192.168.1.100"
	@exit 1
endif
	@./scripts/remote-init.sh $(VPS_IP) $(EMAIL) --yes

# Sync kubeconfig from VPS
sync:
ifndef VPS_IP
	@echo "Error: VPS_IP is required"
	@echo "Usage: make sync VPS_IP=<host>"
	@echo ""
	@echo "Examples:"
	@echo "  make sync VPS_IP=hostinger"
	@echo "  make sync VPS_IP=192.168.1.100"
	@exit 1
endif
	@./scripts/sync-kubeconfig.sh $(VPS_IP)

# Build and push Docker image
build:
	@./scripts/build-and-push.sh

# Full deployment
deploy:
	@./scripts/deploy.sh

# Deploy application only (skip build)
deploy-app:
	@./scripts/deploy.sh --skip-build --skip-monitoring

# Deploy monitoring only
deploy-monitoring:
	@./scripts/deploy.sh --skip-build --skip-app

# Show cluster status
status:
	@export KUBECONFIG=$$HOME/.kube/config-dremer10 && \
	echo "Cluster Info:" && \
	kubectl cluster-info && \
	echo "" && \
	echo "Nodes:" && \
	kubectl get nodes && \
	echo "" && \
	echo "Namespaces:" && \
	kubectl get namespaces

# Show all pods
pods:
	@export KUBECONFIG=$$HOME/.kube/config-dremer10 && \
	kubectl get pods -A

# Show all ingresses
ingress:
	@export KUBECONFIG=$$HOME/.kube/config-dremer10 && \
	kubectl get ingress -A

# Show TLS certificates status (with detailed verification)
certs:
	@./scripts/check-certs.sh

# Show logs for specific environment
logs:
ifndef ENV
	@echo "Error: ENV is required"
	@echo "Usage: make logs ENV=production|staging|qa|dev"
	@exit 1
endif
	@export KUBECONFIG=$$HOME/.kube/config-dremer10 && \
	kubectl logs -f deployment/devops-toolkit -n $(ENV)

# Start local development environment
local:
	@docker-compose up -d
	@echo "Local environment started!"
	@echo "  DevOps-Toolkit: http://localhost"
	@echo "  Prometheus:     http://localhost:9090"
	@echo "  Grafana:        http://localhost:3001"

# Stop local development environment
local-down:
	@docker-compose down

# Clean up Docker images
clean:
	@echo "Cleaning up Docker images..."
	@docker images | grep devops-toolkit | awk '{print $$3}' | xargs -r docker rmi -f
	@echo "Cleanup complete!"

# Scale deployment
scale:
ifndef ENV
	@echo "Error: ENV is required"
	@echo "Usage: make scale ENV=production REPLICAS=3"
	@exit 1
endif
ifndef REPLICAS
	@echo "Error: REPLICAS is required"
	@echo "Usage: make scale ENV=production REPLICAS=3"
	@exit 1
endif
	@export KUBECONFIG=$$HOME/.kube/config-dremer10 && \
	kubectl scale deployment/devops-toolkit --replicas=$(REPLICAS) -n $(ENV) && \
	echo "Scaled $(ENV) to $(REPLICAS) replicas"

# Restart deployment
restart:
ifndef ENV
	@echo "Error: ENV is required"
	@echo "Usage: make restart ENV=production|staging|qa|dev"
	@exit 1
endif
	@export KUBECONFIG=$$HOME/.kube/config-dremer10 && \
	kubectl rollout restart deployment/devops-toolkit -n $(ENV) && \
	echo "Restarted deployment in $(ENV)"

# Watch rollout status
watch:
ifndef ENV
	@echo "Error: ENV is required"
	@echo "Usage: make watch ENV=production|staging|qa|dev"
	@exit 1
endif
	@export KUBECONFIG=$$HOME/.kube/config-dremer10 && \
	kubectl rollout status deployment/devops-toolkit -n $(ENV)

# Port forward for local debugging
forward:
ifndef ENV
	@echo "Error: ENV is required"
	@echo "Usage: make forward ENV=production PORT=8080"
	@exit 1
endif
	@export KUBECONFIG=$$HOME/.kube/config-dremer10 && \
	kubectl port-forward -n $(ENV) svc/devops-toolkit $(or $(PORT),8080):80

# Shell into pod
shell:
ifndef ENV
	@echo "Error: ENV is required"
	@echo "Usage: make shell ENV=production|staging|qa|dev"
	@exit 1
endif
	@export KUBECONFIG=$$HOME/.kube/config-dremer10 && \
	kubectl exec -it -n $(ENV) deployment/devops-toolkit -- /bin/sh
