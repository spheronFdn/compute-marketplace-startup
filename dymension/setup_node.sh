#!/bin/bash

# Set the moniker
MONIKER=${MONIKER:-"YOUR_MONIKER_GOES_HERE"}

# Set node configuration
# babylond config chain-id dymension_1100-1
# babylond config keyring-backend test
# babylond config node tcp://localhost:16457

# Initialize the node
dymd init "$MONIKER" --chain-id dymension_1100-1

# Download genesis and addrbook
curl -Ls https://github.com/dymensionxyz/networks/raw/main/mainnet/dymension/genesis.json > $HOME/.dymension/config/genesis.json
# curl -Ls https://snapshots.kjnodes.com/babylon-testnet/addrbook.json > $HOME/.babylond/config/addrbook.json

# Add seeds
sed -i -e 's/external_address = \"\"/external_address = \"'$(curl httpbin.org/ip | jq -r .origin)':26656\"/g' ~/.dymension/config/config.toml

# # Set minimum gas price
# sed -i -e "s|^minimum-gas-prices *=.*|minimum-gas-prices = \"0.00001ubbn\"|" $HOME/.babylond/config/app.toml

# # Set pruning options
# sed -i \
#   -e 's|^pruning *=.*|pruning = "custom"|' \
#   -e 's|^pruning-keep-recent *=.*|pruning-keep-recent = "100"|' \
#   -e 's|^pruning-keep-every *=.*|pruning-keep-every = "0"|' \
#   -e 's|^pruning-interval *=.*|pruning-interval = "10"|' \
#   $HOME/.babylond/config/app.toml

# # Set custom ports for various services
# sed -i -e "s%^proxy_app = \"tcp://127.0.0.1:26658\"%proxy_app = \"tcp://127.0.0.1:16458\"%; s%^laddr = \"tcp://127.0.0.1:26657\"%laddr = \"tcp://127.0.0.1:16457\"%; s%^pprof_laddr = \"localhost:6060\"%pprof_laddr = \"localhost:16460\"%; s%^laddr = \"tcp://0.0.0.0:26656\"%laddr = \"tcp://0.0.0.0:16456\"%; s%^prometheus_listen_addr = \":26660\"%prometheus_listen_addr = \":16466\"%" $HOME/.babylond/config/config.toml
# sed -i -e "s%^address = \"tcp://localhost:1317\"%address = \"tcp://0.0.0.0:16417\"%; s%^address = \":8080\"%address = \":16480\"%; s%^address = \"localhost:9090\"%address = \"0.0.0.0:16490\"%; s%^address = \"localhost:9091\"%address = \"0.0.0.0:16491\"%; s%:8545%:16445%; s%:8546%:16446%; s%:6065%:16465%" $HOME/.babylond/config/app.toml


# # Download latest chain snapshot
# curl -L https://snapshots.kjnodes.com/babylon-testnet/snapshot_latest.tar.lz4 | tar -Ilz4 -xf - -C $HOME/.babylond
# [[ -f $HOME/.babylond/data/upgrade-info.json ]] && cp $HOME/.babylond/data/upgrade-info.json $HOME/.babylond/cosmovisor/genesis/upgrade-info.json
