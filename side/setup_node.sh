#!/bin/bash

# Set the moniker
MONIKER=${MONIKER:-"YOUR_MONIKER_GOES_HERE"}

# Set node CLI configuration
sided config chain-id side-testnet-2
sided config keyring-backend test
sided config node tcp://localhost:26357

# Initialize the node
sided init "$MONIKER" --chain-id side-testnet-2

# Download genesis and addrbook files
curl -L https://snapshots-testnet.nodejumper.io/side-testnet/genesis.json > $HOME/.side/config/genesis.json
curl -L https://snapshots-testnet.nodejumper.io/side-testnet/addrbook.json > $HOME/.side/config/addrbook.json

# Set seeds
sed -i -e 's|^seeds *=.*|seeds = "d9911bd0eef9029e8ce3263f61680ef4f71a87c4@13.230.121.124:26656,693bdfec73a81abddf6f758aa49321de48456a96@13.231.67.192:26656,9c14080752bdfa33f4624f83cd155e2d3976e303@side-testnet-seed.itrocket.net:45656"|' $HOME/.side/config/config.toml

# Set minimum gas price
sed -i -e 's|^minimum-gas-prices *=.*|minimum-gas-prices = "0.005uside"|' $HOME/.side/config/app.toml

# Set pruning
sed -i \
  -e 's|^pruning *=.*|pruning = "custom"|' \
  -e 's|^pruning-keep-recent *=.*|pruning-keep-recent = "100"|' \
  -e 's|^pruning-interval *=.*|pruning-interval = "17"|' \
  $HOME/.side/config/app.toml

# Change ports
sed -i -e "s%:1317%:26317%; s%:8080%:26380%; s%:9090%:26390%; s%:9091%:26391%; s%:8545%:26345%; s%:8546%:26346%; s%:6065%:26365%" $HOME/.side/config/app.toml
sed -i -e "s%:26658%:26358%; s%:26657%:26357%; s%:6060%:26360%; s%:26656%:26356%; s%:26660%:26361%" $HOME/.side/config/config.toml

# Download latest chain data snapshot
curl "https://snapshots-testnet.nodejumper.io/side-testnet/side-testnet_latest.tar.lz4" | lz4 -dc - | tar -xf - -C "$HOME/.side"


echo "Setup complete. Node configured and ready."