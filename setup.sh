#!/bin/bash
# ==============================================================================
# This script updates the system, installs essential utilities, Docker (with
# Docker Compose), and Foundry for smart contract development. It uses
# screen (instead of tmux) as the terminal multiplexer.
#
# It also updates the smart contract libraries for the Hello World project.
#
# Run this script as your regular user. Some commands require sudo privileges.
# ==============================================================================
 
# Exit immediately if any command fails
set -e

# ------------------------------------------------------------------------------
# System Update & Upgrade
# ------------------------------------------------------------------------------
echo "Updating and upgrading system packages..."
sudo apt update && sudo apt upgrade -y

# ------------------------------------------------------------------------------
# Install Basic Utilities
# ------------------------------------------------------------------------------
# Install required utilities: curl, git, jq, lz4, build-essential, and screen.
echo "Installing required utilities (curl, git, jq, lz4, build-essential, screen)..."
sudo apt install -y curl git jq lz4 build-essential screen

# ------------------------------------------------------------------------------
# Install Prerequisites for Docker
# ------------------------------------------------------------------------------
echo "Installing prerequisites for Docker (ca-certificates, curl, gnupg, lsb-release)..."
sudo apt install -y ca-certificates curl gnupg lsb-release

# ------------------------------------------------------------------------------
# Add Docker's Official GPG Key and Setup Repository
# ------------------------------------------------------------------------------
echo "Adding Docker's official GPG key..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "Setting up the Docker repository..."
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# ------------------------------------------------------------------------------
# Update Package List (including Docker repo)
# ------------------------------------------------------------------------------
echo "Updating package list with Docker repository..."
sudo apt update

# ------------------------------------------------------------------------------
# Install Docker Engine and Related Components
# ------------------------------------------------------------------------------
echo "Installing Docker Engine and related packages..."
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# ------------------------------------------------------------------------------
# Add Current User to Docker Group
# ------------------------------------------------------------------------------
echo "Adding user '$USER' to the docker group (for running Docker without sudo)..."
sudo usermod -aG docker "$USER"

echo "Docker installation complete!"
echo "Please log out and back in (or run 'newgrp docker') to apply group changes."

# ------------------------------------------------------------------------------
# Install Docker Compose (Standalone Binary)
# ------------------------------------------------------------------------------
echo "Installing Docker Compose standalone binary..."
sudo curl -L "https://github.com/docker/compose/releases/download/v2.29.2/docker-compose-$(uname -s)-$(uname -m)" \
  -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# ------------------------------------------------------------------------------
# Alternatively, Setup Docker Compose as a CLI Plugin
# ------------------------------------------------------------------------------
echo "Setting up Docker Compose as a CLI plugin..."
DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
mkdir -p "$DOCKER_CONFIG/cli-plugins"
curl -SL "https://github.com/docker/compose/releases/download/v2.20.2/docker-compose-linux-x86_64" \
  -o "$DOCKER_CONFIG/cli-plugins/docker-compose"
chmod +x "$DOCKER_CONFIG/cli-plugins/docker-compose"

# ------------------------------------------------------------------------------
# Install Foundry (Smart Contract Development Tool)
# ------------------------------------------------------------------------------
echo "Installing Foundry..."
curl -L https://foundry.paradigm.xyz | bash

# Pause briefly to allow Foundry installation to complete
echo "Waiting for Foundry installation to complete..."
sleep 10

# Reload shell configuration based on the current shell (bash or zsh)

if [ -n "$BASH_VERSION" ]; then
    echo "Reloading Bash configuration..."
    source ~/.bashrc
    # Wait 5 seconds before restarting Bash
    sleep 5
    echo "Restarting Bash shell..."
    exec bash
elif [ -n "$ZSH_VERSION" ]; then
    echo "Reloading Zsh configuration..."
    source ~/.zshrc
    # Wait 5 seconds before restarting Zsh
    sleep 5
    echo "Restarting Zsh shell..."
    exec zsh
fi

# Update Foundry (foundryup ensures you have the latest version)
echo "Updating Foundry..."
foundryup

sleep 10

# ------------------------------------------------------------------------------
# Update Smart Contract Libraries for Hello World Project
# ------------------------------------------------------------------------------
echo "Updating smart contract libraries for the Hello World project..."

# Navigate to the contracts library directory
cd ~/infernet-container-starter/projects/hello-world/contracts/lib

# Ensure the Foundry binaries are in PATH
export PATH="/root/.foundry/bin:$PATH"

# Remove the existing forge-std and infernet-sdk directories
echo "Removing existing forge-std and infernet-sdk directories..."
rm -rf forge-std infernet-sdk

# Reinstall forge-std library
echo "Installing forge-std library..."
forge install --no-commit foundry-rs/forge-std

# Reinstall infernet-sdk library
echo "Installing infernet-sdk library..."
forge install --no-commit ritual-net/infernet-sdk

echo "Smart contract library update complete!"

echo "All installations and setups are complete!"



