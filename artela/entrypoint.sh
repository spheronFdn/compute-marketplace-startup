#!/bin/bash
set -e

# Initialize node configuration
artelad config chain-id artela_11822-1
artelad config keyring-backend test
artelad config node tcp://localhost:23457
artelad init "${MONIKER}" --chain-id artela_11822-1

# Download genesis and addrbook
curl -Ls https://snap.nodex.one/artela-testnet/genesis.json > $DAEMON_HOME/genesis/bin/config/genesis.json
curl -Ls https://snap.nodex.one/artela-testnet/addrbook.json > $DAEMON_HOME/genesis/bin/config/addrbook.json

# Configure seeds
sed -i -e "s|^seeds *=.*|seeds = \"d1d43cc7c7aef715957289fd96a114ecaa7ba756@testnet-seeds.nodex.one:23410\"|" $DAEMON_HOME/genesis/bin/config/config.toml

# Configure gas prices
sed -i -e "s|^minimum-gas-prices *=.*|minimum-gas-prices = \"0.025uart\"|" $DAEMON_HOME/genesis/bin/config/app.toml

# Pruning settings
sed -i \
  -e 's|^pruning *=.*|pruning = "custom"|' \
  -e 's|^pruning-keep-recent *=.*|pruning-keep-recent = "100"|' \
  -e 's|^pruning-keep-every *=.*|pruning-keep-every = "0"|' \
  -e 's|^pruning-interval *=.*|pruning-interval = "10"|' \
  $DAEMON_HOME/genesis/bin/config/app.toml

# Configure a custom port (if needed)
sed -i -e "s%^proxy_app = \"tcp://127.0.0.1:26658\"%proxy_app = \"tcp://127.0.0.1:23458\"%; \
          s%^laddr = \"tcp://127.0.0.1:26657\"%laddr = \"tcp://127.0.0.1:23457\"%; \
          s%^pprof_laddr = \"localhost:6060\"%pprof_laddr = \"localhost:23460\"%; \
          s%^laddr = \"tcp://0.0.0.0:26656\"%laddr = \"tcp://0.0.0.0:23456\"%; \
          s%^prometheus_listen_addr = \":26660\"%prometheus_listen_addr = \":23466\"%" $DAEMON_HOME/genesis/bin/config/config.toml

sed -i -e "s%^address = \"tcp://0.0.0.0:1317\"%address = \"tcp://0.0.0.0:23417\"%; \
          s%^address = \":8080\"%address = \":23480\"%; \
          s%^address = \"0.0.0.0:9090\"%address = \"0.0.0.0:23490\"%; \
          s%^address = \"0.0.0.0:9091\"%address = \"0.0.0.0:23491\"%; \
          s%:8545%:23445%; \
          s%:8546%:23446%; \
          s%:6065%:23465%" $DAEMON_HOME/genesis/bin/config/app.toml

# Start cosmovisor
cosmovisor run start
