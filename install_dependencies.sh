#!/bin/bash

# Log file to track installation progress
LOG_FILE="/var/log/install_dependencies.log"
exec > >(tee -a $LOG_FILE) 2>&1

# Function to check if the script is run as root
check_root() {
  if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root. Please run with sudo or as root."
    exit 1
  fi
}

# Function to log message
log_message() {
  local message="$1"
  echo "[INFO] $(date '+%Y-%m-%d %H:%M:%S') - $message"
}

# Function to install dependencies
install_dependencies() {
  log_message "Updating and upgrading the system..."
  sudo apt update && sudo apt upgrade -y

  log_message "Installing essential packages: curl, git, jq, lz4, build-essential, tmux..."
  sudo apt -qy install curl git jq lz4 build-essential tmux

  log_message "Installing Docker..."
  sudo apt install docker.io -y

  log_message "Installing Docker Compose..."
  sudo curl -L "https://github.com/docker/compose/releases/download/v2.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose

  log_message "Setting up Docker Compose CLI plugin..."
  DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
  mkdir -p $DOCKER_CONFIG/cli-plugins
  curl -SL https://github.com/docker/compose/releases/download/v2.20.2/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
  chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose

  log_message "Verifying Docker Compose version..."
  docker compose version

  log_message "Adding user to Docker group..."
  sudo usermod -aG docker $USER

  log_message "Installation complete!"
}

# Function to advise user about logging out
advise_logout() {
  log_message "To apply Docker group changes, please log out and log back in or restart your machine."
}

# Main script execution starts here
check_root

sudo apt install make

log_message "Starting the installation of dependencies..."

# Run the installation
install_dependencies

# Advise user for logout
advise_logout

