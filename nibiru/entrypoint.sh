#!/bin/bash

# Exit script on error
set -e

# Check if the MONIKER_NAME environment variable is set
if [ -z "$MONIKER_NAME" ]; then
  echo "MONIKER_NAME environment variable is not set."
  exit 1
fi

# Initialize the chain with the provided moniker name
nibid init $MONIKER_NAME --chain-id=$NETWORK --home $HOME/.nibid

# Copy the genesis file
curl -s https://networks.testnet.nibiru.fi/$NETWORK/genesis > $HOME/.nibid/config/genesis.json

# Update seeds list in the configuration
SEEDS=$(curl -s https://networks.testnet.nibiru.fi/$NETWORK/seeds)
sed -i 's|seeds =.*|seeds = "'$SEEDS'"|g' $HOME/.nibid/config/config.toml

# Set minimum gas prices
sed -i 's/minimum-gas-prices =.*/minimum-gas-prices = "0.025unibi"/g' $HOME/.nibid/config/app.toml

# Setup state-sync parameters
RPC_SERVERS=$(curl -s https://networks.testnet.nibiru.fi/$NETWORK/rpc_servers)
TRUST_HEIGHT=$(curl -s https://networks.testnet.nibiru.fi/$NETWORK/trust_height)
TRUST_HASH=$(curl -s https://networks.testnet.nibiru.fi/$NETWORK/trust_hash)

sed -i "s|enable =.*|enable = true|g" $HOME/.nibid/config/config.toml
sed -i "s|rpc_servers =.*|rpc_servers = \"$RPC_SERVERS\"|g" $HOME/.nibid/config/config.toml
sed -i "s|trust_height =.*|trust_height = \"$TRUST_HEIGHT\"|g" $HOME/.nibid/config/config.toml
sed -i "s|trust_hash =.*|trust_hash = \"$TRUST_HASH\"|g" $HOME/.nibid/config/config.toml

# Start nibid
nibid start
