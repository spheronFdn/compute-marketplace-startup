#!/bin/bash

. $HOME/.bashrc 

# Run the command and capture the output
OUTPUT=$(fuel-core-keygen new --key-type peering | tee fuel-key.txt)

# Extract the secret using a tool like jq (assuming the output is JSON)
SECRET=$(echo $OUTPUT | jq -r '.secret')

# Export the secret to a file
echo "$SECRET" > /tmp/p2p_secret.txt

echo "Set P2P_SECRET=$SECRET"