echo "Downloading Sui Node Binary..."

curl -s https://api.github.com/repos/MystenLabs/sui/releases/latest | grep "/sui-node" | cut -d : -f 2,3 | tr -d \" | wget -qi -
chmod +x sui-node

echo "Running Sui Node"

wget -O ./fullnode.yaml https://raw.githubusercontent.com/MystenLabs/sui/main/crates/sui-config/data/fullnode-template.yaml 

./sui-node -- --config-path fullnode.yaml
