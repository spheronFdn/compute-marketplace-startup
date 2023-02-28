sudo apt install golang -y
git clone https://github.com/sei-protocol/sei-chain.git
cd sei-chain

#git checkout $(curl -s https://api.github.com/repos/sei-protocol/sei-chain/releases/latest | grep "tag_name" | cut -d : -f 2,3 |  tr -d \" | tr -d ,)
git checkout 2.0.36beta

make install
mv $HOME/go/bin/seid /usr/bin/

seid version --long | head

echo $MONIKER

seid init $MONIKER --chain-id atlantic-2 -o

curl https://raw.githubusercontent.com/sei-protocol/testnet/master/atlantic-2/genesis.json > ~/.sei/config/genesis.json
curl https://raw.githubusercontent.com/sei-protocol/testnet/master/atlantic-2/addrbook.json > ~/.sei/config/addrbook.json

seid start
