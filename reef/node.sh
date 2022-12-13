echo "Downloading Reef Node Binary..."

curl -s https://api.github.com/repos/reef-defi/reef-chain/releases/latest | grep "/reef-node" | cut -d : -f 2,3 | tr -d \" | wget -qi -

chmod +x reef-node

echo "Running Reef Node"

./reef-node \
  --chain mainnet \
  --base-path /reef/fullnode \
  --pruning=archive \
  --port 30333 \
  --ws-port 9944 \
  --rpc-port 9933 \
  --rpc-methods Auto \
  --rpc-cors all \
  --rpc-external \
  --ws-external \
  --name MyRPCNode