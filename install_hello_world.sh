#!/bin/bash

set -e  # Exit immediately if a command fails
set -o pipefail  # Exit if any command in a pipeline fails

# Navigate to the contracts directory of the hello-world project
echo "📂 Navigating to contracts directory of hello-world project..."
cd ~/infernet-container-starter/projects/hello-world/contracts
sleep 5

# Install the 'forge-std' dependency using forge
echo "⬇️ Installing forge-std dependency..."
forge install --no-commit foundry-rs/forge-std
sleep 5

# Remove the '/usr/bin/forge' binary if exists
echo "🗑️ Removing '/usr/bin/forge'..."
rm /usr/bin/forge
sleep 5

# Install the 'infernet-sdk' dependency using forge
echo "⬇️ Installing infernet-sdk dependency..."
forge install --no-commit ritual-net/infernet-sdk
sleep 5

# Navigate back to the original directory
echo "📂 Returning to the previous directory..."
cd ../../../
sleep 5

echo "✅ Script execution complete!"

