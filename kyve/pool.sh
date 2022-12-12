echo "Downloading Kyve Linux Binary..."

wget https://github.com/KYVENetwork/kyvejs/releases/download/%40kyve%2Fkysor%401.0.0-beta.1/kysor-linux-x64.zip

unzip kysor-linux-x64.zip
mv kysor-linux-x64 kysor
chmod +x kysor

echo "Fetching arweave wallet..."
wget -O ./arweave.json $LINK_ARWEAVE_WALLET

echo "Initialising Node..."
./kysor init --network $NETWORK --auto-download-binaries

echo "Creating Kyve Wallet..."
echo $MNEMONIC | ./kysor valaccounts create --name wallet --pool $POOL --storage-priv $(cat ./arweave.json) --verbose --metrics --recover

echo "Starting Node..."
./kysor start --valaccount wallet