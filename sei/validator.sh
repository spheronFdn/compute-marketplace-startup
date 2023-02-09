sudo apt install golang -y
git clone https://github.com/sei-protocol/sei-chain.git
cd sei-chain

git checkout $(curl -s https://api.github.com/repos/sei-protocol/sei-chain/releases/latest | grep "tag_name" | cut -d : -f 2,3 |  tr -d \" | tr -d ,)

make install
mv $HOME/go/bin/seid /usr/bin/

seid version --long | head

seid init $MONIKER --chain-id sei-devnet-1 -o

curl https://raw.githubusercontent.com/sei-protocol/testnet/master/sei-devnet-1/genesis.json > ~/.sei/config/genesis.json
curl https://raw.githubusercontent.com/sei-protocol/testnet/master/sei-devnet-1/addrbook.json > ~/.sei/config/addrbook.json

seid start &

PUBKEY=$(seid tendermint show-validator)

echo $MNEMONIC | seid keys add mainwallet --recover --keyring-backend test

seid query bank balances $ACCOUNT_ADDRESS

seid tx staking create-validator \
    --amount=$AMOUNT \
    --pubkey=$PUBKEY \
    --moniker=$MONIKER \
    --chain-id=$CHAIN_ID \
    --from=$ACCOUNT_NAME \
    --commission-rate=$COMMISSION_RATE \
    --commission-max-rate=$COMMISSION_MAX_RATE \
    --commission-max-change-rate=$COMMISSION_MAX_CHANGE_RATE \
    --min-self-delegation=$MIN_SELF_DELEGATION \
    --fees=$FEES
