#!/bin/bash

# Set variablesdd other dependencies separated by spaces
URL="https://zkevm-testing.b-cdn.net/prover.zip"
CONFIG_DIR="/usr/src/app"
ZIP_FILE="prover.zip"
TEMP_DIR="temp_unzip_dir"

# Download the zip file
echo "Downloading zip file from $URL..."
curl -o $ZIP_FILE $URL

# Unzip the file
echo "Unzipping the file..."
mkdir $TEMP_DIR $CONFIG_DIR
unzip $ZIP_FILE -d $TEMP_DIR

# Move the files
echo "Moving files to the destination directory..."
cp -r $TEMP_DIR/prover/public.prover.config.json $APP_DIR/config.json

# Clean up
echo "Cleaning up..."
rm -rf $TEMP_DIR $ZIP_FILE

echo "All done."
