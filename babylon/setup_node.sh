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
PEERS=86eecc48c181a2e508852f6f3a170b99a09cae87@74.208.197.25:26656,f887f4a18019563bcf3fc23079eb68b86931a766@37.60.226.84:16456,e27df9014fd0d37d917fb33f2d9de7500a8fab70@35.91.9.184:26656,3fb6251a235480e81c8f964ff25304b2b4e7a071@43.128.69.178:26501,bfff3794fa6f5238c71151b57786a4a28f2afc5b@5.181.51.159:26656
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
curl -L https://snapshots.polkachu.com/testnet-snapshots/babylon/babylon_44206.tar.lz4 | tar -Ilz4 -xf - -C $HOME/.babylond
[[ -f $HOME/.babylond/data/upgrade-info.json ]] && cp $HOME/.babylond/data/upgrade-info.json $HOME/.babylond/cosmovisor/genesis/upgrade-info.json

# Start the node (if applicable, or configure to start with Docker container)
# This part may need to be handled outside of the script for Docker deployments

echo "Setup complete. Node configured and ready."