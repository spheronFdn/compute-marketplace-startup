#!/bin/bash

# Execute setup script to ensure all configurations and directories are properly set up
/usr/local/bin/setup_node.sh

# Define the full path to cosmovisor
COSMOVISOR_PATH="/root/go/bin/cosmovisor"

# Ensure environment variables are set for Cosmovisor
export DAEMON_HOME=$HOME/.lava
export DAEMON_NAME=lavad
export UNSAFE_SKIP_BACKUP=true

# Start the Babylon node through Cosmovisor using the full path
exec $COSMOVISOR_PATH run start