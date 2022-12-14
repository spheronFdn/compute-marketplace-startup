echo "Getting config file..."

wget -O daemon.config.json $CONFIG

mv daemon.config.json $HOME/.ceramic/daemon.config.json

echo "Installing the Ceramic CLI..."

npm install -g @ceramicnetwork/cli

echo "Running Ceramic Node..."

ceramic daemon