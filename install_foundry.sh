#!/bin/bash

set -e  # Exit immediately if a command fails
set -o pipefail  # Exit if any command in a pipeline fails

# Stop and remove containers defined in docker-compose
echo "🛑 Stopping and removing existing Docker containers..."
docker compose -f deploy/docker-compose.yaml down
sleep 5

# Create and move into the 'foundry' directory
echo "📂 Creating and moving into the 'foundry' directory..."
mkdir -p foundry && cd foundry
sleep 5

# Download and install Foundry
echo "⬇️ Downloading and installing Foundry..."
curl -L https://foundry.paradigm.xyz | bash
sleep 5

# Reload shell configuration
echo "🔄 Reloading shell configuration..."
source ~/.bashrc
sleep 5

# Update Foundry
echo "⚙️ Updating Foundry..."
foundryup
sleep 5

echo "✅ Foundry installation complete!"

