#!/bin/bash

# Start Geth in the background
/usr/local/bin/geth --auroria --http --http.api eth,net,engine,admin --datadir=data/testnet/geth --http.addr=0.0.0.0 --http.corsdomain=* --ws --ws.api=eth,engine,net,web3 --ws.addr=0.0.0.0 --ws.origins=* --authrpc.vhosts=* --authrpc.addr=0.0.0.0 --authrpc.jwtsecret=configs/testnet/jwtsecret --syncmode=full &
# /usr/local/bin/geth --auroria --http --http.api eth,net,engine,admin --datadir=data/testnet/geth --authrpc.addr=0.0.0.0 --authrpc.jwtsecret=configs/testnet/jwtsecret --syncmode=full

echo "Geth Node configured and ready."

# Start Pryzm in the background
/usr/local/bin/beacon-chain --auroria --datadir=data/testnet/beacon --rpc-host=0.0.0.0 --grpc-gateway-host=0.0.0.0 --execution-endpoint=http://localhost:8551 --accept-terms-of-use --jwt-secret=configs/testnet/jwtsecret --minimum-peers-per-subnet=0 --enable-debug-rpc-endpoints &
# /usr/local/bin/beacon-chain --auroria --datadir=data/testnet/beacon --execution-endpoint=http://localhost:8551 --jwt-secret=configs/testnet/jwtsecret --accept-terms-of-use
echo "Beacon Node configured and ready."

# Keep the container running since both processes are in the background
# wait

