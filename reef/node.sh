echo "Downloading Reef Node Binary..."

curl -s https://api.github.com/repos/reef-defi/reef-chain/releases/latest | grep "/reef-node" | cut -d : -f 2,3 | tr -d \" | wget -qi -

if [ "$ARCHIVE" == "true" ]; then
  PRUNE="--pruning=archive"
else
  PRUNE=""
fi

chmod +x reef-node

echo "Running Reef Node"

./reef-node --chain $NETWORK --base-path /reef/fullnode $PRUNE --port 30333 --ws-port 9944 --rpc-port 9933 --rpc-methods Auto --rpc-cors all --rpc-external --ws-external --name MyRPCNode
