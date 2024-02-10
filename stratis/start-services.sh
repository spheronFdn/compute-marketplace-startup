#!/bin/bash

# Start Geth in the background
/usr/local/bin/geth --datadir=data/testnet/geth --http --http.api=eth,engine,net,web3 --http.addr=0.0.0.0 --http.corsdomain=* --ws --ws.api=eth,engine,net,web3 --ws.addr=0.0.0.0 --ws.origins=* --authrpc.vhosts=* --authrpc.addr=0.0.0.0 --authrpc.jwtsecret=configs/testnet/jwtsecret --syncmode=full &

# Start Pryzm in the background
/usr/local/bin/beacon-chain --p2p-static-id --datadir=data/testnet/beacon --rpc-host=0.0.0.0 --grpc-gateway-host=0.0.0.0 --execution-endpoint=http://localhost:8551 --accept-terms-of-use --jwt-secret=configs/testnet/jwtsecret --suggested-fee-recipient=0x123463a4B065722E99115D6c222f267d9cABb524 --minimum-peers-per-subnet=0 --enable-debug-rpc-endpoints &

# Keep the container running since both processes are in the background
wait
