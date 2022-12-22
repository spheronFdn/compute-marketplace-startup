echo "Downloading Sui Node Binary..."

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"
rustup update

cargo install --locked --git https://github.com/MystenLabs/sui.git --branch devnet sui sui-node

curl -fLJO https://github.com/MystenLabs/sui-genesis/raw/main/devnet/genesis.blob

echo "Running Sui Node"

wget -O ./fullnode.yaml https://raw.githubusercontent.com/MystenLabs/sui/main/crates/sui-config/data/fullnode-template.yaml 

cargo run --release --bin sui-node -- --config-path fullnode.yaml
