#!/bin/bash

set -e  # Exit immediately if a command fails
set -o pipefail  # Exit if any command in a pipeline fails

# Navigate to the project directory (change this to your actual directory)
echo "📂 Navigating to project directory..."
cd ~/infernet-container-starter  # Change if necessary
sleep 5

# Stop Docker Compose services
echo "⬇️ Stopping Docker Compose services..."
docker-compose -f deploy/docker-compose.yaml down
sleep 5

# Start Docker Compose services
echo "⬆️ Starting Docker Compose services..."
docker-compose -f deploy/docker-compose.yaml up -d  # The '-d' flag runs it in detached mode
sleep 5

echo "✅ Docker Compose services restarted successfully!"

