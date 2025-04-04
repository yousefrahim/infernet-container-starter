#!/bin/bash

######################################################################
#                                                                    #
#   🚀 Docker Compose & Tmux Automation Script                      #
#   ------------------------------------------------------------   #
#   This script automates the process of restarting Docker         #
#   Compose services and running a deployment command inside       #
#   a tmux session. It ensures a smooth restart of your            #
#   containerized application.                                      #
#                                                                    #
######################################################################

# Exit immediately if any command fails
set -e  
# Exit if any command in a pipeline fails
set -o pipefail  

######################################################################
# 📂 Step 1: Navigate to the Project Directory
######################################################################
echo "📂 Navigating to project directory..."
cd ~/infernet-container-starter  # Change this path if needed
sleep 5

######################################################################
# ⬇️ Step 2: Stop Running Docker Compose Services
######################################################################
echo "⬇️ Stopping running Docker Compose services..."
docker-compose -f deploy/docker-compose.yaml down
sleep 5

######################################################################
# ⬆️ Step 3: Start Docker Compose Services
######################################################################
echo "⬆️ Launching Docker Compose services..."
docker-compose -f deploy/docker-compose.yaml up -d  # Runs in the background
sleep 5

echo "✅ Docker Compose services restarted successfully!"

######################################################################
# 🖥️ Step 4: Initialize a New Tmux Session
######################################################################
echo "🖥️ Creating a new tmux session..."
tmux new-session -d -s node

######################################################################
# 🚀 Step 5: Run Deployment Command in Tmux Session
######################################################################
echo "🚀 Running deployment command inside tmux session..."
tmux send-keys -t node "project=hello-world make deploy-container" C-m

######################################################################
# 🔌 Step 6: Detach from Tmux Session
######################################################################
echo "🔌 Detaching from tmux session..."
tmux detach -s node

######################################################################
# ✅ Final Step: Ensure Successful Exit
######################################################################
exit 0