#!/bin/bash

# Set variables
DEPENDENCIES="curl unzip" # Add other dependencies separated by spaces
URL="http://example.com/path/to/your/file.zip"
CONFIG_DIR="/usr/src/app"
ZIP_FILE="downloaded_file.zip"
TEMP_DIR="temp_unzip_dir"

# Install dependencies
echo "Installing dependencies..."
sudo apt update && sudo apt install -y $DEPENDENCIES

# Download the zip file
echo "Downloading zip file from $URL..."
curl -o $ZIP_FILE $URL

# Unzip the file
echo "Unzipping the file..."
mkdir $TEMP_DIR
unzip $ZIP_FILE -d $TEMP_DIR

# Move the files
echo "Moving files to the destination directory..."
mv $TEMP_DIR/* $CONFIG_DIR

# Clean up
echo "Cleaning up..."
rm -rf $TEMP_DIR $ZIP_FILE

echo "All done."
