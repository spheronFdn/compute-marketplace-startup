echo "Getting config file..."

wget -O daemon.config.json $CONFIG

mkdir $HOME/.ceramic

mv daemon.config.json $HOME/.ceramic/daemon.config.json

echo "Installing the Ceramic CLI..."

npm install -g @ceramicnetwork/cli

echo "Running Ceramic Node..."

ceramic daemon --config $HOME/.ceramic/daemon.config.json
