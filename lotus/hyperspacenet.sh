sudo apt update -y
sudo apt install mesa-opencl-icd ocl-icd-opencl-dev gcc git bzr jq pkg-config curl clang build-essential hwloc libhwloc-dev wget -y

wget -c https://golang.org/dl/go1.18.8.linux-amd64.tar.gz -O - | sudo tar -xz -C /usr/local
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc && source ~/.bashrc

curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh -s -- -y
source "$HOME/.cargo/env"

git clone https://github.com/filecoin-project/lotus.git
cd lotus/

git checkout ntwk/hyperspace # Hyperspace testnet

mv ~/.lotus ~/.lotus-backup

export PATH=$PATH:/usr/local/go/bin

make clean && make hyperspacenet
sudo make install

lotus --version

wget -O config.toml https://raw.githubusercontent.com/filecoin-project/lotus/ntwk/hyperspace/documentation/en/default-lotus-config.toml

sed -i '/#ListenAddress =/c\  ListenAddress = "/ip4/0.0.0.0/tcp/1234/http"' config.toml

FULLNODE_API_INFO=wss://wss.hyperspace.node.glif.io/apigw/lotus lotus daemon --lite --config config.toml
