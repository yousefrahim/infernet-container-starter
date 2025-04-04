#!/bin/bash

# ==============================================================================
# This script prompts the user for an EVM private key with at least $5 worth of
# ETH on the BASE network. It then updates the specified configuration files
# with the provided private key.
#
# SECURITY WARNING: Handle private keys with extreme caution. Ensure this script
# is run in a secure environment and that the private key is not exposed or logged.
# ==============================================================================

# Exit immediately if any command fails
set -e

# ------------------------------------------------------------------------------
# Prompt User for Private Key
# ------------------------------------------------------------------------------
read -sp "Enter your EVM private key (starting with 0x and 64 characters long): " user_private_key
echo

# ------------------------------------------------------------------------------
# Validate Private Key Format
# ------------------------------------------------------------------------------
if [[ ! $user_private_key =~ ^0x[a-fA-F0-9]{64}$ ]]; then
    echo "Invalid private key format. Ensure it starts with '0x' and is 64 hexadecimal characters long."
    exit 1
fi

# ------------------------------------------------------------------------------
# Define File Paths
# ------------------------------------------------------------------------------
CONFIG_FILE="projects/hello-world/container/config.json"
MAKEFILE="projects/hello-world/contracts/Makefile"

# ------------------------------------------------------------------------------
# Update config.json with the Provided Private Key
# ------------------------------------------------------------------------------
if [ -f "$CONFIG_FILE" ]; then
    # Use jq to update the private_key field in the config.json
    jq --arg pk "$user_private_key" '.chain.wallet.private_key = $pk' "$CONFIG_FILE" > tmp.$$.json && mv tmp.$$.json "$CONFIG_FILE"
    echo "Updated private_key in $CONFIG_FILE."
else
    echo "Error: $CONFIG_FILE not found."
    exit 1
fi

# ------------------------------------------------------------------------------
# Update Makefile with the Provided Private Key
# ------------------------------------------------------------------------------
if [ -f "$MAKEFILE" ]; then
    # Use sed to replace the sender variable in the Makefile
    sed -i.bak "s|^\(sender\s*:=\s*\).*|\1$user_private_key|" "$MAKEFILE"
    echo "Updated sender in $MAKEFILE."
else
    echo "Error: $MAKEFILE not found."
    exit 1
fi

echo "Configuration files updated successfully."
