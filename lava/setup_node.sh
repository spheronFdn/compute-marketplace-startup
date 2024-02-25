#!/bin/bash

# Setting up environment variables
MONIKER=${MONIKER:-"YOUR_MONIKER_GOES_HERE"}
export DAEMON_HOME="/root/.lava"

# Initialize the node
# lavad config chain-id lava-testnet-2
# lavad config keyring-backend test
# lavad config node tcp://localhost:20457

# Initialize the node
lavad init $MONIKER --chain-id lava-testnet-2

# Download genesis and addrbook
curl -Ls https://raw.githubusercontent.com/lavanet/lava-config/main/testnet-2/genesis_json/genesis.json > $DAEMON_HOME/config/genesis.json
# curl -Ls https://snap.nodex.one/lava-testnet/addrbook.json > $DAEMON_HOME/config/addrbook.json

# Verify genesis file (optional but recommended)
echo "f7a0c7d2587d2bf640570309137c905eac834f0aba99f90b4c10f45ef8334583  $DAEMON_HOME/config/genesis.json" | sha256sum -c -

# Configure seeds and gas prices
sed -i -e "s|^seeds *=.*|seeds = \"3a445bfdbe2d0c8ee82461633aa3af31bc2b4dc0@testnet2-seed-node.lavanet.xyz:26656,e593c7a9ca61f5616119d6beb5bd8ef5dd28d62d@testnet2-seed-node2.lavanet.xyz:26656\"|" $DAEMON_HOME/config/config.toml
sed -i -e "s|^minimum-gas-prices *=.*|minimum-gas-prices = \"0ulava\"|" $DAEMON_HOME/config/app.toml

# Configure pruning
sed -i \
  -e 's|^pruning *=.*|pruning = "custom"|' \
  -e 's|^pruning-keep-recent *=.*|pruning-keep-recent = "100"|' \
  -e 's|^pruning-keep-every *=.*|pruning-keep-every = "0"|' \
  -e 's|^pruning-interval *=.*|pruning-interval = "10"|' \
  $DAEMON_HOME/config/app.toml

# Configure custom ports
# Add your custom port configurations here, similar to the provided instructions
# sed -i -e "s%^proxy_app = \"tcp://127.0.0.1:26658\"%proxy_app = \"tcp://127.0.0.1:20458\"%; s%^laddr = \"tcp://127.0.0.1:26657\"%laddr = \"tcp://127.0.0.1:20457\"%; s%^pprof_laddr = \"localhost:6060\"%pprof_laddr = \"localhost:20460\"%; s%^laddr = \"tcp://0.0.0.0:26656\"%laddr = \"tcp://0.0.0.0:20456\"%; s%^prometheus_listen_addr = \":26660\"%prometheus_listen_addr = \":20466\"%" $DAEMON_HOME/config/config.toml
# sed -i -e "s%^address = \"tcp://0.0.0.0:1317\"%address = \"tcp://0.0.0.0:20417\"%; s%^address = \":8080\"%address = \":20480\"%; s%^address = \"0.0.0.0:9090\"%address = \"0.0.0.0:20490\"%; s%^address = \"0.0.0.0:9091\"%address = \"0.0.0.0:20491\"%; s%:8545%:20445%; s%:8546%:20446%; s%:6065%:20465%" $DAEMON_HOME/config/app.toml

# Download latest chain snapshot (optional but can speed up sync)
# curl -L https://snap.nodex.one/lava-testnet/lava-latest.tar.lz4 | tar -I lz4 -xf - -C $DAEMON_HOME
# [[ -f $DAEMON_HOME/data/upgrade-info.json ]] && cp $DAEMON_HOME/data/upgrade-info.json $DAEMON_HOME/cosmovisor/genesis/upgrade-info.json

# Start the node (if applicable, or configure to start with Docker container)
# This part may need to be handled outside of the script for Docker deployments
echo "Setup complete. Node configured and ready."