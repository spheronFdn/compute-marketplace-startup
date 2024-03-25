#!/bin/bash

# Set variables
DEPENDENCIES="unzip" # Add other dependencies separated by spaces
URL="https://bafybeigjhwufcgrg4fdffu65wcdhshn2vuh3dpeqkg6ewk2m5tx5rcuh6q.ipfs.sphn.link/zkevm-node.zip"
APP_DIR="/"
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
mkdir $TEMP_DIR $APP_DIR $PK_DIR
unzip $ZIP_FILE -d $TEMP_DIR

# Move the files
echo "Moving files to the destination directory..."
mv $TEMP_DIR/zkevm-node/* $APP_DIR
ls $APP_DIR
# mv $TEMP_DIR/zkevm-node/pk/* $PK_DIR

# Clean up
echo "Cleaning up..."
rm -rf $TEMP_DIR $ZIP_FILE

echo "All done."
