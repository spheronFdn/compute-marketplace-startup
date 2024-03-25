#!/bin/bash

# Set variables
DEPENDENCIES="curl unzip" # Add other dependencies separated by spaces
URL="https://github.com/spheronFdn/compute-marketplace-startup/raw/rekpero/polygon-cdk/polygon-cdk/zkevm-node.zip"
APP_DIR="/app"
PK_DIR="/pk"
ZIP_FILE="zkevm-node.zip"
TEMP_DIR="temp_unzip_dir"

# Install dependencies
echo "Installing dependencies..."
apt update && apk add $DEPENDENCIES

# Download the zip file
echo "Downloading zip file from $URL..."
curl -o $ZIP_FILE $URL

# Unzip the file
echo "Unzipping the file..."
mkdir $TEMP_DIR
unzip $ZIP_FILE -d $TEMP_DIR

# Move the files
echo "Moving files to the destination directory..."
mv $TEMP_DIR/app/* $APP_DIR
mv $TEMP_DIR/pk/* $PK_DIR

# Clean up
echo "Cleaning up..."
rm -rf $TEMP_DIR $ZIP_FILE

echo "All done."
