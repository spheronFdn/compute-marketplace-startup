#!/bin/bash

# Reminder to set up the Pryzm Feeder wallet manually.
echo "Remember to set up the Pryzm Feeder wallet manually."
# pryzmd keys add feeder
# OR
# pryzmd keys add feeder --recover

# Download Pryzm Feeder configuration
echo "Downloading Pryzm Feeder configuration..."
mkdir -p /pryzmfeeder && cd /pryzmfeeder
wget https://storage.googleapis.com/pryzm-zone/feeder/config.yaml https://storage.googleapis.com/pryzm-zone/feeder/init.sql https://storage.googleapis.com/pryzm-zone/feeder/docker-compose.yml

# Update config.yaml with sed
# echo "Updating config.yaml with placeholders..."
# sed -i 's/feeder: ".*"/feeder: "your_pryzm_feeder_wallet_address"/' config.yaml
# sed -i 's/feederMnemonic: ".*"/feederMnemonic: "your_pryzm_feeder_mnemonic"/' config.yaml
# sed -i 's/validator: ".*"/validator: "your_valoper_address"/' config.yaml

# Install PostgreSQL (optional, based on your Docker container setup)
echo "Installing PostgreSQL..."
apt-get update && apt-get install -y postgresql postgresql-contrib
service postgresql start

# Configure PostgreSQL
echo "Configuring PostgreSQL..."
sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD 'postgres';"
psql -U postgres -h localhost -W -c "\i /pryzmfeeder/init.sql"

# Reminder for manual steps
echo "Please ensure the config.yaml has been correctly updated with your actual details."
echo "Remember to initiate oracle delegate feed consent tx manually."

# Reminder to start Pryzm Feeder manually due to Docker usage
echo "To start Pryzm Feeder, ensure Docker is correctly set up and run the following command in the pryzmfeeder directory:"
echo "docker run --name=pryzm-feeder --network host --restart=always -v '$(pwd)/config.yaml:/app/config.yaml' -v '$(pwd)/logs:/app/logs' europe-docker.pkg.dev/pryzm-zone/core/pryzm-feeder:0.3.4"
