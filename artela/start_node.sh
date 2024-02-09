#!/bin/bash

# Execute setup script to ensure all configurations and directories are properly set up
/usr/local/bin/setup_node.sh

# Define the full path to cosmovisor
COSMOVISOR_PATH="/root/go/bin/cosmovisor"

# Ensure environment variables are set for Cosmovisor
export DAEMON_HOME=$HOME/.artelad
export DAEMON_NAME=artelad
export UNSAFE_SKIP_BACKUP=true

# Start the Dymension node
exec $COSMOVISOR_PATH run start


# babylond tx checkpointing create-validator --amount 1000000ubbn --pubkey $(babylond tendermint show-validator) --moniker "MitraNode" --details "Mitra" --website "https://spheron.network" --chain-id bbn-test-2 --commission-rate 0.05 --commission-max-rate 0.20 --commission-max-change-rate 0.01 --min-self-delegation 1 --from wallet --gas-adjustment 1.4 --gas auto --gas-prices 0.00001ubbn -y