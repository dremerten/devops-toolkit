#!/bin/bash

set -e

echo "DevOps Observatory - Environment Setup"
echo "======================================"
echo ""

if [ -f .env ]; then
    echo "Warning: .env file already exists!"
    read -p "Do you want to overwrite it? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Aborted. Keeping existing .env file."
        exit 0
    fi
fi

echo "Let's set up your environment variables..."
echo ""

read -p "GitHub Username: " GITHUB_USERNAME
echo ""

read -p "MariaDB Root Password [press Enter for random]: " MYSQL_ROOT_PASSWORD
if [ -z "$MYSQL_ROOT_PASSWORD" ]; then
    MYSQL_ROOT_PASSWORD=$(openssl rand -base64 32)
    echo "Generated random root password"
fi
echo ""

read -p "MariaDB User Password [press Enter for random]: " MYSQL_PASSWORD
if [ -z "$MYSQL_PASSWORD" ]; then
    MYSQL_PASSWORD=$(openssl rand -base64 32)
    echo "Generated random user password"
fi
echo ""

cat > .env << EOF
DB_HOST=mariadb
DB_PORT=3306
DB_USER=devops
DB_PASSWORD=${MYSQL_PASSWORD}
DB_NAME=observatory

MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
MYSQL_DATABASE=observatory
MYSQL_USER=devops
MYSQL_PASSWORD=${MYSQL_PASSWORD}

PROMETHEUS_URL=http://prometheus:9090
K8S_IN_CLUSTER=false

REACT_APP_API_URL=http://localhost:8080
REACT_APP_WS_URL=ws://localhost:8080/ws
CHOKIDAR_USEPOLLING=true

GITHUB_USERNAME=${GITHUB_USERNAME}
GITHUB_TOKEN=your-github-token-for-packages

HOSTINGER_API_TOKEN=your-hostinger-api-token
TF_VAR_hostinger_api_token=your-hostinger-api-token
TF_VAR_ssh_key_id=your-ssh-key-id
TF_VAR_vps_plan_id=vps-1
EOF

echo ""
echo "✓ .env file created successfully!"
echo ""
echo "Important passwords (save these securely):"
echo "=========================================="
echo "MariaDB Root Password: ${MYSQL_ROOT_PASSWORD}"
echo "MariaDB User Password: ${MYSQL_PASSWORD}"
echo ""
echo "Next steps:"
echo "1. Edit .env and add your GitHub token (for packages)"
echo "2. Add Hostinger API token when ready for production"
echo "3. Run: docker-compose up"
echo ""
