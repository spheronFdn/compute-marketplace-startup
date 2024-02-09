#!/bin/bash

# Set the moniker
MONIKER=${MONIKER:-"YOUR_MONIKER_GOES_HERE"}

# Set node configuration
# artelad config chain-id dymension_1100-1
# artelad config keyring-backend test
# artelad config node tcp://localhost:16457

# Initialize the node
artelad init "$MONIKER"

# Download genesis and addrbook
curl -Ls https://docs.artela.network/assets/files/genesis-314f4b0294712c1bc6c3f4213fa76465.json > $HOME/.artelad/config/genesis.json
# curl -Ls https://snapshots.kjnodes.com/babylon-testnet/addrbook.json > $HOME/.artelad/config/addrbook.json

# Add seeds
sed -i 's/seeds = ""/seeds = "9e2fbfc4b32a1b013e53f3fc9b45638f4cddee36@47.254.66.177:26656,aa416d3628dcce6e87d4b92d1867c8eca36a70a7@47.254.93.86:26656,30fb0055aced21472a01911353101bc4cd356bb3@47.89.230.117:26656"/' $HOME/.artelad/config/config.toml

#Set state sync
sed -i 's/enable = false/enable = true/' $HOME/.artelad/config/config.toml
sed -i 's/trust_height = 0/trust_height = 114011/' $HOME/.artelad/config/config.toml
sed -i 's/trust_hash = ""/trust_hash = "94077D92B3DE77C3AE94BEBF496601E7CBA3EEF7CD7E17BD8513F16D9DDA8712"/' $HOME/.artelad/config/config.toml
sed -i 's/rpc_servers = ""/rpc_servers = "47.254.66.177:26657,47.254.93.86:26657"/' $HOME/.artelad/config/config.toml

# # Set minimum gas price
sed -i -e "s|^minimum-gas-prices *=.*|minimum-gas-prices = \"0.02uart\"|" $HOME/.artelad/config/app.toml

# # Set pruning options
sed -i \
  -e 's|^pruning *=.*|pruning = "custom"|' \
  -e 's|^pruning-keep-recent *=.*|pruning-keep-recent = "362880"|' \
  -e 's|^pruning-keep-every *=.*|pruning-keep-every = "0"|' \
  -e 's|^pruning-interval *=.*|pruning-interval = "100"|' \
  $HOME/.artelad/config/app.toml

# # Set custom ports for various services
# sed -i -e "s%^proxy_app = \"tcp://127.0.0.1:26658\"%proxy_app = \"tcp://127.0.0.1:16458\"%; s%^laddr = \"tcp://127.0.0.1:26657\"%laddr = \"tcp://127.0.0.1:16457\"%; s%^pprof_laddr = \"localhost:6060\"%pprof_laddr = \"localhost:16460\"%; s%^laddr = \"tcp://0.0.0.0:26656\"%laddr = \"tcp://0.0.0.0:16456\"%; s%^prometheus_listen_addr = \":26660\"%prometheus_listen_addr = \":16466\"%" $HOME/.artelad/config/config.toml
# sed -i -e "s%^address = \"tcp://localhost:1317\"%address = \"tcp://0.0.0.0:16417\"%; s%^address = \":8080\"%address = \":16480\"%; s%^address = \"localhost:9090\"%address = \"0.0.0.0:16490\"%; s%^address = \"localhost:9091\"%address = \"0.0.0.0:16491\"%; s%:8545%:16445%; s%:8546%:16446%; s%:6065%:16465%" $HOME/.artelad/config/app.toml


# # Download latest chain snapshot
# curl -L https://snapshots.kjnodes.com/babylon-testnet/snapshot_latest.tar.lz4 | tar -Ilz4 -xf - -C $HOME/.artelad
# [[ -f $HOME/.artelad/data/upgrade-info.json ]] && cp $HOME/.artelad/data/upgrade-info.json $HOME/.artelad/cosmovisor/genesis/upgrade-info.json
