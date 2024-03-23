#!/bin/bash

# Setting up environment variables
MONIKER=${MONIKER:-"YOUR_MONIKER_GOES_HERE"}

# Initialize node
wardend init $MONIKER

# Get genesis file  
curl https://raw.githubusercontent.com/warden-protocol/networks/main/testnet-alfama/genesis.json > ~/.warden/config/genesis.json

# Set minimum gas price and peers
sed -i 's/minimum-gas-prices = ""/minimum-gas-prices = "0.0025uward"/' ~/.warden/config/app.toml
sed -i 's/persistent_peers = ""/persistent_peers = "6a8de92a3bb422c10f764fe8b0ab32e1e334d0bd@sentry-1.alfama.wardenprotocol.org:26656,7560460b016ee0867cae5642adace5d011c6c0ae@sentry-2.alfama.wardenprotocol.org:26656,24ad598e2f3fc82630554d98418d26cc3edf28b9@sentry-3.alfama.wardenprotocol.org:26656"/' ~/.warden/config/config.toml

# Setup state sync
SNAP_RPC_SERVERS="https://rpc.sentry-1.alfama.wardenprotocol.org:443,https://rpc.sentry-2.alfama.wardenprotocol.org:443,https://rpc.sentry-3.alfama.wardenprotocol.org:443" 
LATEST_HEIGHT=$(curl -s "https://rpc.alfama.wardenprotocol.org/block" | jq -r .result.block.header.height)
BLOCK_HEIGHT=$((LATEST_HEIGHT - 2000))
TRUST_HASH=$(curl -s "https://rpc.alfama.wardenprotocol.org/block?height=$BLOCK_HEIGHT" | jq -r .result.block_id.hash)

sed -i.bak -E "s|^(enable[[:space:]]+=[[:space:]]+).*$|\1true| ; \
s|^(rpc_servers[[:space:]]+=[[:space:]]+).*$|\1\"$SNAP_RPC_SERVERS\"| ; \
s|^(trust_height[[:space:]]+=[[:space:]]+).*$|\1$BLOCK_HEIGHT| ; \
s|^(trust_hash[[:space:]]+=[[:space:]]+).*$|\1\"$TRUST_HASH\"|" ~/.warden/config/config.toml