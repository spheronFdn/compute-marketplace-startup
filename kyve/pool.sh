echo "Downloading Kyve Linux Binary..."

wget https://github.com/KYVENetwork/node/releases/download/%40kyve%2Fevm%401.9.2/kyve-linux-x64.zip

unzip kyve-linux-x64.zip
chmod +x kyve-linux-x64

ls

wget -O ./arweave.json $LINK_ARWEAVE_WALLET

echo "Running Node..."

echo ./kyve-linux-x64 start --pool $POOL --valaccount "$MNEMONIC" --storage-priv "$(cat ./arweave.json)" --network "$NETWORK" --metrics