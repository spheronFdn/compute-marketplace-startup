#!/bin/bash

# Download Pryzm Feeder configuration
echo "Downloading Pryzm Feeder configuration..."
mkdir -p /pryzmfeeder && cd /pryzmfeeder
wget https://storage.googleapis.com/pryzm-zone/feeder/config.yaml https://storage.googleapis.com/pryzm-zone/feeder/init.sql https://storage.googleapis.com/pryzm-zone/feeder/docker-compose.yml


# Install PostgreSQL (optional, based on your Docker container setup)
echo "Installing PostgreSQL..."
service postgresql start

# Configure PostgreSQL
echo "Configuring PostgreSQL..."
# Set the PostgreSQL 'postgres' user password
psql -U postgres -c "ALTER USER postgres WITH PASSWORD 'postgres';"

# Execute the SQL initialization script
psql -U postgres -h localhost -f "$HOME/pryzmfeeder/init.sql"

# Reminder to start Pryzm Feeder manually due to Docker usage
echo "To start Pryzm Feeder, ensure Docker is correctly set up and run the following command in the pryzmfeeder directory:"

# pryzmd keys add feeder
# pryzmd keys show wallet --bech val -a