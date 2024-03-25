#!/bin/bash

# Set variables
DEPENDENCIES="unzip" # Add other dependencies separated by spaces
URL="https://bafybeic2z5w3rdo4jvn4cqfncouj3arw54io3rduzxa7fvkq5hguhuvjwq.ipfs.sphn.link/zkevm-node.zip"
APP_DIR="/app"
PK_DIR="/pk"
ZIP_FILE="zkevm-node.zip"
TEMP_DIR="temp_unzip_dir"

# Install dependencies
echo "Installing dependencies..."
# apt update && apk add $DEPENDENCIES

# Download the zip file
echo "Downloading zip file from $URL..."
curl -o $ZIP_FILE $URL

# Unzip the file
echo "Unzipping the file..."
mkdir $TEMP_DIR $PK_DIR $APP_DIR
unzip $ZIP_FILE -d $TEMP_DIR

# Move the files
echo "Moving files to the destination directory..."
cp -r $TEMP_DIR/zkevm-node/app/public.genesis.config.json $APP_DIR/genesis.json
cp -r $TEMP_DIR/zkevm-node/app/public.node.config.toml $APP_DIR/config.toml
cp -r $TEMP_DIR/zkevm-node/app/config.local.toml $APP_DIR/config.local.toml
cp -r $TEMP_DIR/zkevm-node/pk/* $PK_DIR
# mv $TEMP_DIR/zkevm-node/pk/* $PK_DIR

# Clean up
echo "Cleaning up..."
rm -rf $TEMP_DIR $ZIP_FILE

echo "All done."
