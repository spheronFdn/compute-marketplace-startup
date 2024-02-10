#!/bin/bash

# install junctiond
# git clone https://github.com/airchains-network/junction.git
# cd junction
# git checkout v0.0.2-beta
# ignite chain build 

# Initialize Junction Node with MONIKER
# rm -rf ~/.junction
$HOME/go/bin/junctiond init $MONIKER

# Copy the genesis file
cp /junction/resources/genesis/genesis.json ~/.junction/config/

# Start the Junction Node with PERSISTENT_PEERS
$HOME/go/bin/junctiond start --api.enable --api.address "tcp://0.0.0.0:1317" --rpc.laddr "tcp://0.0.0.0:26657" --p2p.laddr "tcp://0.0.0.0:26656" --p2p.persistent_peers="$PERSISTENT_PEERS" --minimum-gas-prices="0.0001dair"
