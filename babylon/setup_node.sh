#!/bin/bash

# Set the moniker
MONIKER=${MONIKER:-"YOUR_MONIKER_GOES_HERE"}

# Initialize the node
babylond init "$MONIKER" --chain-id bbn-test-3

# Download genesis and addrbook
wget -O genesis.json https://snapshots.polkachu.com/testnet-genesis/babylon/genesis.json --inet4-only
mv genesis.json ~/.babylond/config

wget -O addrbook.json https://snapshots.polkachu.com/testnet-addrbook/babylon/addrbook.json --inet4-only
mv addrbook.json ~/.babylond/config

# Add seeds
PEERS=69c1b7e1eb114703733c3000baa6c008ebc70073@65.109.113.233:20656,6990fd085c9e2e8c9256f144799d18df51f74022@141.94.195.144:26656,49b15e202497c231ebe7b2a56bb46cfc60eff78c@135.181.134.151:46656,ce1caddb401d530cc2039b219de07994fc333dcf@162.19.97.200:26656,26cb133489436035829b6920e89105046eccc841@178.63.95.125:26656,25abb614b96fa606fb5514fcf711635e8e861d8f@217.72.207.107:26656
sed -i.bak -e "s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" $HOME/.babylond/config/config.toml

sed -i -e "s|^seeds *=.*|seeds = \"ade4d8bc8cbe014af6ebdf3cb7b1e9ad36f412c0@testnet-seeds.polkachu.com:20656\"|" $HOME/.babylond/config/config.toml

# Set minimum gas price
sed -i -e "s|^minimum-gas-prices *=.*|minimum-gas-prices = \"0.00001ubbn\"|" $HOME/.babylond/config/app.toml

# Switch to signet
# sed -i -e "s|^network *=.*|network = \"signet\"|" $HOME/.babylond/config/app.toml

# Set pruning
sed -i \
  -e 's|^pruning *=.*|pruning = "custom"|' \
  -e 's|^pruning-keep-recent *=.*|pruning-keep-recent = "100"|' \
  -e 's|^pruning-keep-every *=.*|pruning-keep-every = "0"|' \
  -e 's|^pruning-interval *=.*|pruning-interval = "10"|' \
  $HOME/.babylond/config/app.toml

# Download latest chain snapshot
# curl -L https://snapshots.polkachu.com/testnet-snapshots/babylon/babylon_44206.tar.lz4 | tar -Ilz4 -xf - -C $HOME/.babylond
# [[ -f $HOME/.babylond/data/upgrade-info.json ]] && cp $HOME/.babylond/data/upgrade-info.json $HOME/.babylond/cosmovisor/genesis/upgrade-info.json

wget -O babylon_47173.tar.lz4 https://snapshots.polkachu.com/testnet-snapshots/babylon/babylon_47173.tar.lz4 --inet4-only
lz4 -c -d babylon_47173.tar.lz4  | tar -x -C $HOME/.babylond
# Start the node (if applicable, or configure to start with Docker container)
# This part may need to be handled outside of the script for Docker deployments

echo "Setup complete. Node configured and ready."