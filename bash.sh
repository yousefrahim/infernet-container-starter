#!/bin/bash

# Start a new tmux session
tmux new-session -d -s node

# Run the deploy-container command in the tmux session
tmux send-keys -t node "project=hello-world make deploy-container" C-m

# Detach from the tmux session
tmux detach -s node

# Ignore errors and continue
exit 0

sleep 30 
