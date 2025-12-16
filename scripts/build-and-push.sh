#!/bin/bash
set -e

# Build and Push Docker Image (Run from Local Laptop)
# Builds the DevOps-Toolkit Docker image and pushes to Docker Hub

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

echo "========================================="
echo "Build and Push Docker Image"
echo "========================================="
echo ""

# Load environment variables if .env exists
if [ -f "$PROJECT_ROOT/.env" ]; then
    echo -e "${BLUE}Loading environment variables from .env...${NC}"
    export $(cat "$PROJECT_ROOT/.env" | grep -v '^#' | xargs)
else
    echo -e "${YELLOW}Warning: .env file not found${NC}"
    echo "Please create .env file with your Docker Hub credentials:"
    echo "  cp .env.example .env"
    echo "  # Edit .env with your credentials"
    exit 1
fi

# Check required variables
if [ -z "$DOCKER_USERNAME" ]; then
    echo -e "${RED}Error: DOCKER_USERNAME not set in .env${NC}"
    exit 1
fi

if [ -z "$DOCKER_PASSWORD" ]; then
    echo -e "${RED}Error: DOCKER_PASSWORD not set in .env${NC}"
    exit 1
fi

# Get version tag (optional)
VERSION="${1:-latest}"
IMAGE_NAME="$DOCKER_USERNAME/devops-toolkit"

echo -e "${GREEN}Configuration:${NC}"
echo "  Docker Username: $DOCKER_USERNAME"
echo "  Image Name: $IMAGE_NAME"
echo "  Version Tag: $VERSION"
echo "  Build Context: $PROJECT_ROOT/devops-tools-source"
echo ""

# Check if Docker is running
if ! docker info &> /dev/null; then
    echo -e "${RED}Error: Docker is not running${NC}"
    echo "Please start Docker Desktop and try again"
    exit 1
fi

# Login to Docker Hub
echo -e "${YELLOW}[1/4] Logging in to Docker Hub...${NC}"
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
echo -e "${GREEN}✓ Logged in successfully${NC}"

# Build the image
echo ""
echo -e "${YELLOW}[2/4] Building Docker image...${NC}"
echo "This may take 2-5 minutes depending on your connection..."
echo ""

docker build \
    -t "$IMAGE_NAME:$VERSION" \
    -t "$IMAGE_NAME:latest" \
    -f "$PROJECT_ROOT/devops-tools-source/Dockerfile" \
    "$PROJECT_ROOT/devops-tools-source"

echo ""
echo -e "${GREEN}✓ Image built successfully${NC}"

# Show image details
echo ""
echo "Image details:"
docker images "$IMAGE_NAME" --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}\t{{.CreatedAt}}"

# Push the image
echo ""
echo -e "${YELLOW}[3/4] Pushing image to Docker Hub...${NC}"
echo "Pushing $IMAGE_NAME:$VERSION..."
docker push "$IMAGE_NAME:$VERSION"

if [ "$VERSION" != "latest" ]; then
    echo "Pushing $IMAGE_NAME:latest..."
    docker push "$IMAGE_NAME:latest"
fi

echo ""
echo -e "${GREEN}✓ Image pushed successfully${NC}"

# Logout
echo ""
echo -e "${YELLOW}[4/4] Logging out...${NC}"
docker logout
echo -e "${GREEN}✓ Logged out${NC}"

echo ""
echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}Build and Push Complete!${NC}"
echo -e "${GREEN}=========================================${NC}"
echo ""
echo -e "${BLUE}Image available at:${NC}"
echo "  $IMAGE_NAME:$VERSION"
if [ "$VERSION" != "latest" ]; then
    echo "  $IMAGE_NAME:latest"
fi
echo ""
echo -e "${BLUE}Next Steps:${NC}"
echo ""
echo "1. Deploy to cluster:"
echo -e "   ${YELLOW}./scripts/deploy.sh${NC}"
echo ""
echo "2. Or update specific environment:"
echo -e "   ${YELLOW}kubectl set image deployment/devops-toolkit \\${NC}"
echo -e "   ${YELLOW}  devops-toolkit=$IMAGE_NAME:$VERSION -n production${NC}"
echo ""
echo "3. Monitor rollout:"
echo -e "   ${YELLOW}kubectl rollout status deployment/devops-toolkit -n production${NC}"
echo ""
