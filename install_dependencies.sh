#!/bin/bash

set -e  # Exit immediately if a command fails
set -o pipefail  # Exit if any command in a pipeline fails

LOG_FILE="/var/log/install_dependencies.log"
exec > >(tee -a $LOG_FILE) 2>&1

check_root() {
  if [ "$(id -u)" -ne 0 ]; then
    echo "[ERROR] This script must be run as root. Please run with sudo or as root." >&2
    exit 1
  fi
}

log_message() {
  local message="$1"
  echo "[INFO] $(date '+%Y-%m-%d %H:%M:%S') - $message"
}

error_exit() {
  echo "[ERROR] $1" >&2
  exit 1
}

install_dependencies() {
  log_message "Updating and upgrading the system..."
  sudo apt update && sudo apt upgrade -y || error_exit "Failed to update system."

  log_message "Installing essential packages..."
  sudo apt -qy install curl git jq lz4 build-essential tmux || error_exit "Failed to install essential packages."

  log_message "Installing Docker..."
  sudo apt install -y docker.io || error_exit "Failed to install Docker."

  log_message "Installing Docker Compose..."
  sudo curl -L "https://github.com/docker/compose/releases/download/v2.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose || error_exit "Failed to download Docker Compose."
  sudo chmod +x /usr/local/bin/docker-compose || error_exit "Failed to set executable permissions for Docker Compose."

  log_message "Setting up Docker Compose CLI plugin..."
  DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
  mkdir -p "$DOCKER_CONFIG/cli-plugins"
  curl -SL "https://github.com/docker/compose/releases/download/v2.20.2/docker-compose-linux-x86_64" -o "$DOCKER_CONFIG/cli-plugins/docker-compose" || error_exit "Failed to download Docker Compose plugin."
  chmod +x "$DOCKER_CONFIG/cli-plugins/docker-compose" || error_exit "Failed to set permissions for Docker Compose plugin."

  log_message "Verifying Docker Compose version..."
  docker compose version || error_exit "Docker Compose installation verification failed."

  log_message "Adding user to Docker group..."
  sudo usermod -aG docker $USER || error_exit "Failed to add user to Docker group."

  log_message "Installation complete!"
}

advise_logout() {
  log_message "To apply Docker group changes, please log out and log back in or restart your machine."
}

# New commands to install Forge and Infernet SDK
install_foundry() {
  log_message "Navigating to contracts directory..."
  cd ~/infernet-container-starter/projects/hello-world/contracts || error_exit "Failed to change directory to contracts."

  log_message "Removing old libraries..."
  rm -rf lib/infernet-sdk || error_exit "Failed to remove 'infernet-sdk'."
  rm -rf lib/forge-std || error_exit "Failed to remove 'forge-std'."

  log_message "Installing Forge and Infernet SDK..."
  forge install --no-commit foundry-rs/forge-std || error_exit "Failed to install 'forge-std'."
  forge install --no-commit ritual-net/infernet-sdk || error_exit "Failed to install 'infernet-sdk'."

  log_message "Updating Foundry..."
  foundryup || error_exit "Failed to update Foundry."

  log_message "Foundry installation complete!"
}

check_root

log_message "Starting the installation of dependencies..."
sudo apt install -y make || error_exit "Failed to install make."

install_dependencies
advise_logout

# Run Foundry installation and updates
install_foundry
