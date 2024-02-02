#!/bin/bash

# Define the full path to cosmovisor
COSMOVISOR_PATH="/root/go/bin/cosmovisor"

# Ensure environment variables are set for Cosmovisor
export DAEMON_HOME=$HOME/.babylond
export DAEMON_NAME=babylond
export UNSAFE_SKIP_BACKUP=true

# Start the Babylon node through Cosmovisor using the full path
exec $COSMOVISOR_PATH run start
