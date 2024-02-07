#!/bin/bash

# Run the command and capture the output
OUTPUT=$(command: fuel-core-keygen new --key-type peering)

# Extract the secret using a tool like jq (assuming the output is JSON)
SECRET=$(echo $OUTPUT | jq -r '.secret')

# Export the secret to a file
echo "P2P_SECRET=$SECRET" > .env

echo "Set P2P_SECRET=$SECRET"