#!/bin/bash

# Assuming the environment variable is named WALLET_KEY
# Ensure the environment variable is exported or defined in the current shell session
# export WALLET_KEY="your_dynamic_value"

# Check if WALLET_KEY is set and not empty
if [ ! -z "$WALLET_KEY" ]; then
    IDENTITY_TOML="identity.toml"

    # Check if identity.toml exists
    if [ ! -f "$IDENTITY_TOML" ]; then
        # If the file doesn't exist, create it with the dynamic data within single quotes
        echo "avail_secret_seed_phrase = '$WALLET_KEY'" > "$IDENTITY_TOML"
    else
        # If the file exists, update it, ensuring the value is within single quotes
        awk -v data="$WALLET_KEY" 'BEGIN{found=0} /avail_secret_seed_phrase =/{print "avail_secret_seed_phrase = '\''" data "'\''"; found=1; next}1; END{if(!found)print "avail_secret_seed_phrase = '\''" data "'\''"}' "$IDENTITY_TOML" > temp.toml && mv temp.toml "$IDENTITY_TOML"
    fi
else
    echo "No wallet key provided, a new avail seed phrase will be created later!"
fi
