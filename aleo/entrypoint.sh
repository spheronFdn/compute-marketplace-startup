#!/bin/bash

# Check if the wallet exists; if not, create a new wallet
if [ ! -f "~/.aleo/wallet" ]; then
    echo "Creating new Aleo wallet..."
    snarkos account new
fi

# Create a screen session and run the Aleo prover
screen -dmS aleo bash -c './run-prover.sh; exec bash'

# Keep the container running
tail -f /dev/null
