#!/bin/bash
# Load profile to ensure paths are set
. $HOME/.profile

# Configure moniker
MONIKER="${MONIKER:-default-moniker}" # Default moniker name if not set

# Initialize node
pryzmd config chain-id indigo-1
pryzmd config keyring-backend test
pryzmd config node tcp://localhost:23257

# Initialize the node
pryzmd init $MONIKER --chain-id indigo-1

# Download genesis & addrbook
curl -Ls https://snap.nodex.one/pryzm-testnet/genesis.json > $HOME/.pryzm/config/genesis.json
curl -Ls https://snap.nodex.one/pryzm-testnet/addrbook.json > $HOME/.pryzm/config/addrbook.json

# Configure seeds
sed -i -e "s|^seeds *=.*|seeds = \"d1d43cc7c7aef715957289fd96a114ecaa7ba756@testnet-seeds.nodex.one:23210\"|" $HOME/.pryzm/config/config.toml

# Configure gas prices
sed -i -e "s|^minimum-gas-prices *=.*|minimum-gas-prices = \"0.015upryzm,0.01factory/pryzm15k9s9p0ar0cx27nayrgk6vmhyec3lj7vkry7rx/uusdsim\"|" $HOME/.pryzm/config/app.toml

# Configure pruning
sed -i \
  -e 's|^pruning *=.*|pruning = "custom"|' \
  -e 's|^pruning-keep-recent *=.*|pruning-keep-recent = "100"|' \
  -e 's|^pruning-keep-every *=.*|pruning-keep-every = "0"|' \
  -e 's|^pruning-interval *=.*|pruning-interval = "19"|' \
  $HOME/.pryzm/config/app.toml

# Configure custom port (optional)
# Update this section based on your specific port configurations
sed -i -e "s%^proxy_app = \"tcp://127.0.0.1:26658\"%proxy_app = \"tcp://127.0.0.1:23258\"%; s%^laddr = \"tcp://127.0.0.1:26657\"%laddr = \"tcp://127.0.0.1:23257\"%; s%^pprof_laddr = \"localhost:6060\"%pprof_laddr = \"localhost:23260\"%; s%^laddr = \"tcp://0.0.0.0:26656\"%laddr = \"tcp://0.0.0.0:23256\"%; s%^prometheus_listen_addr = \":26660\"%prometheus_listen_addr = \":23266\"%" $HOME/.pryzm/config/config.toml
sed -i -e "s%^address = \"tcp://0.0.0.0:1317\"%address = \"tcp://0.0.0.0:23217\"%; s%^address = \":8080\"%address = \":23280\"%; s%^address = \"0.0.0.0:9090\"%address = \"0.0.0.0:23290\"%; s%^address = \"0.0.0.0:9091\"%address = \"0.0.0.0:23291\"%; s%:8545%:23245%; s%:8546%:23246%; s%:6065%:23265%" $HOME/.pryzm/config/app.toml

# Download latest chain snapshot
curl -L https://snap.nodex.one/pryzm-testnet/pryzm-latest.tar.lz4 | tar -Ilz4 -xf - -C $HOME/.pryzm
[[ -f $HOME/.pryzm/data/upgrade-info.json ]] && cp $HOME/.pryzm/data/upgrade-info.json $HOME/.pryzm/cosmovisor/genesis/upgrade-info.json

# Start the node (if applicable, or configure to start with Docker container)
# This part may need to be handled outside of the script for Docker deployments

echo "Setup complete. Node configured and ready."