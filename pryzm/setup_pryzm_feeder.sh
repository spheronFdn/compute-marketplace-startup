#!/bin/bash

# Download Pryzm Feeder configuration
echo "Downloading Pryzm Feeder configuration..."
mkdir -p /pryzmfeeder && cd /pryzmfeeder
wget https://storage.googleapis.com/pryzm-zone/feeder/config.yaml https://storage.googleapis.com/pryzm-zone/feeder/init.sql https://storage.googleapis.com/pryzm-zone/feeder/docker-compose.yml


# Install PostgreSQL (optional, based on your Docker container setup)
echo "Installing PostgreSQL..."
service postgresql start

# PostgreSQL version: Adjust this as necessary
PG_VERSION='12' # Example version, adjust based on your actual version

# Path to pg_hba.conf
PG_HBA_CONF_PATH="/etc/postgresql/${PG_VERSION}/main/pg_hba.conf"

# This sed command targets lines with local connections and changes peer to trust
sed -i 's/local\s*all\s*postgres\s*peer/local all postgres trust/' "$PG_HBA_CONF_PATH"
sed -i 's/local\s*all\s*all\s*peer/local all all trust/' "$PG_HBA_CONF_PATH"

# Or, if using a service command is possible in your container
service postgresql reload

# Configure PostgreSQL
echo "Configuring PostgreSQL..."
# Assuming password authentication is configured
psql -U postgres -c "ALTER USER postgres WITH PASSWORD 'postgres';"

# Execute the SQL initialization script
psql -U postgres -d postgres -f "/pryzmfeeder/init.sql"

# This sed command targets lines with local connections and changes peer to trust
sed -i 's/local\s*all\s*postgres\s*peer/local all postgres trust/' "$PG_HBA_CONF_PATH"
sed -i 's/local\s*all\s*all\s*trust/local all all peer/' "$PG_HBA_CONF_PATH"

# Or, if using a service command is possible in your container
service postgresql reload

# Reminder to start Pryzm Feeder manually due to Docker usage
echo "To start Pryzm Feeder, ensure Docker is correctly set up and run the following command in the pryzmfeeder directory:"

# pryzmd keys add feeder
# pryzmd keys show wallet --bech val -a