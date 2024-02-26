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
# PEERS=e8f550ed3fea54eda7fa3f8ed3d6b17cb222fedf@95.111.239.100:26656,82191d0763999d30e3ddf96cc366b78694d8cee1@162.19.169.211:26656,49b15e202497c231ebe7b2a56bb46cfc60eff78c@135.181.134.151:46656,c0ee3e7f140b2de189ce853cfccb9fb2d922eb66@95.217.203.226:26656,4dbf5157b735de59fb84be26f2bd40a16cee056c@54.238.212.246:26656
# sed -i -e "s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" $HOME/.babylond/config/config.toml

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
curl -L https://snapshots.polkachu.com/testnet-snapshots/babylon/babylon_44206.tar.lz4 | tar -Ilz4 -xf - -C $HOME/.babylond
[[ -f $HOME/.babylond/data/upgrade-info.json ]] && cp $HOME/.babylond/data/upgrade-info.json $HOME/.babylond/cosmovisor/genesis/upgrade-info.json

# Start the node (if applicable, or configure to start with Docker container)
# This part may need to be handled outside of the script for Docker deployments

echo "Setup complete. Node configured and ready."