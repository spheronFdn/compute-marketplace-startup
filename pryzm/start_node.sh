#!/bin/bash

# Execute setup script to ensure all configurations and directories are properly set up
/home/pryzm/setup_node.sh

# Define the full path to cosmovisor
# COSMOVISOR_PATH="/usr/local/go/bin/go/cosmovisor"

# Ensure environment variables are set for Cosmovisor
export DAEMON_HOME=$HOME/.pryzm
export DAEMON_NAME=pryzmd
export UNSAFE_SKIP_BACKUP=true

# Start Cosmovisor with the pryzm node
echo "Starting Pryzm node with Cosmovisor..."
$HOME/go/bin/cosmovisor run start



# babylond tx checkpointing create-validator --amount 1000000ubbn --pubkey $(babylond tendermint show-validator) --moniker "MitraNode" --details "Mitra" --website "https://spheron.network" --chain-id bbn-test-2 --commission-rate 0.05 --commission-max-rate 0.20 --commission-max-change-rate 0.01 --min-self-delegation 1 --from wallet --gas-adjustment 1.4 --gas auto --gas-prices 0.00001ubbn -y