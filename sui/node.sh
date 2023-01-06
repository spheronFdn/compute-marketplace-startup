echo "Downloading Sui genesis.blob and fullnode.yaml config..."

curl -fLJO https://github.com/MystenLabs/sui-genesis/raw/main/devnet/genesis.blob
curl -o fullnode.yaml https://raw.githubusercontent.com/MystenLabs/sui/main/crates/sui-config/data/fullnode-template.yaml

/usr/local/bin/sui-node --config-path fullnode.yaml
