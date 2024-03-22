#!/bin/bash

# Set the moniker
MONIKER=${MONIKER:-"YOUR_MONIKER_GOES_HERE"}

# Set node CLI configuration
babylond config set client chain-id bbn-test-3
babylond config set client keyring-backend test
babylond config set client node tcp://localhost:20657

# Initialize the node
babylond init "$MONIKER" --chain-id bbn-test-3

# Download genesis and addrbook files
curl -L https://snapshots-testnet.nodejumper.io/babylon-testnet/genesis.json > $HOME/.babylond/config/genesis.json
curl -L https://snapshots-testnet.nodejumper.io/babylon-testnet/addrbook.json > $HOME/.babylond/config/addrbook.json

# Add seeds
sed -i -e "s|^seeds *=.*|seeds = \"49b4685f16670e784a0fe78f37cd37d56c7aff0e@3.14.89.82:26656,9cb1974618ddd541c9a4f4562b842b96ffaf1446@3.16.63.237:26656\"|" $HOME/.babylond/config/config.toml

# Change network to signet:
sed -i 's/minimum-gas-prices = "0stake"/minimum-gas-prices = "0.00001ubbn"/' $HOME/.babylond/config/app.toml
sed -i -e "s|^network *=.*|network = \"signet\"|" $HOME/.babylond/config/app.toml

# Set minimum gas price:
sed -i -e "s|^minimum-gas-prices *=.*|minimum-gas-prices = \"0.00001ubbn\"|" $HOME/.babylond/config/app.toml

# Set peers:
# PEERS="cac4a3199ab2f361eb86ee445a0c2d3f8ab5a5dd@62.171.154.184:26656,59b484e1370f211ba74f5b8e1316a0752a55d090@65.108.75.197:26656,11a40047f142b07119b29262da9f7800640b0699@88.217.142.242:16456,434cbf7c51cf082bb92fca773bd12d5ccd7b1e44@109.199.119.227:26656,2af11b08ea816acb95d4de33c3de07a32c1cc801@82.208.20.66:26656"
# sed -i 's|^persistent_peers *=.*|persistent_peers = "'$PEERS'"|' $HOME/.babylond/config/config.toml

sed -i \
  -e 's|^pruning *=.*|pruning = "custom"|' \
  -e 's|^pruning-keep-recent *=.*|pruning-keep-recent = "100"|' \
  -e 's|^pruning-keep-every *=.*|pruning-keep-every = "0"|' \
  -e 's|^pruning-interval *=.*|pruning-interval = "10"|' \
  $HOME/.babylond/config/app.toml

# Change ports
sed -i -e "s%:1317%:20617%; s%:8080%:20680%; s%:9090%:20690%; s%:9091%:20691%; s%:8545%:20645%; s%:8546%:20646%; s%:6065%:20665%" $HOME/.babylond/config/app.toml
sed -i -e "s%:26658%:20658%; s%:26657%:20657%; s%:6060%:20660%; s%:26656%:20656%; s%:26660%:20661%" $HOME/.babylond/config/config.toml

# Download latest chain data snapshot
curl "https://snapshots-testnet.nodejumper.io/babylon-testnet/babylon-testnet_latest.tar.lz4" | lz4 -dc - | tar -xf - -C "$HOME/.babylond"


echo "Setup complete. Node configured and ready."