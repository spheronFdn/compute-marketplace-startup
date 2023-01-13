git clone https://github.com/sei-protocol/sei-chain.git
cd sei-chain

git checkout $(curl -s https://api.github.com/repos/sei-protocol/sei-chain/releases/latest | grep "tag_name" | cut -d : -f 2,3 |  tr -d \" | tr -d ,)

make install

seid version --long | head

seid init $MONIKER --chain-id sei-devnet-1 -o

curl https://raw.githubusercontent.com/sei-protocol/testnet/master/sei-devnet-1/genesis.json > ~/.sei/config/genesis.json
curl https://raw.githubusercontent.com/sei-protocol/testnet/master/sei-devnet-1/addrbook.json > ~/.sei/config/addrbook.json

seid start