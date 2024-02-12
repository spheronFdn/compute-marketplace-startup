#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 [your_pryzm_feeder_wallet_address] [your_pryzm_feeder_wallet_mnemonic] [your_pryzm_validator]"
    exit 1
fi

FEEDER_WALLET_ADDRESS="$1"
FEEDER_WALLET_MNEMONIC="$2"
FEEDER_VALIDATOR="$3"

# Reminder for manual steps
echo "Please ensure the config.yaml has been correctly updated with your actual details."
echo $FEEDER_WALLET_ADDRESS
echo $FEEDER_WALLET_MNEMONIC
echo $FEEDER_VALIDATOR

# Update config.yaml with sed
echo "Updating config.yaml with placeholders..."
sed -i "s/feeder: \".*\"/feeder: \"$FEEDER_WALLET_ADDRESS\"/" /pryzmfeeder/config.yaml
sed -i "s/feederMnemonic: \".*\"/feederMnemonic: \"$FEEDER_WALLET_MNEMONIC\"/" /pryzmfeeder/config.yaml
sed -i "s/validator: \".*\"/validator: \"$FEEDER_VALIDATOR\"/" /pryzmfeeder/config.yaml

pryzmd tx oracle delegate-feed-consent $FEEDER_WALLET_ADDRESS --fees 2000factory/pryzm15k9s9p0ar0cx27nayrgk6vmhyec3lj7vkry7rx/uusdsim,3000upryzm --from feeder


docker run --name=pryzm-feeder --network host --restart=always -v '/pryzmfeeder/config.yaml:/app/config.yaml' -v /var/run/docker.sock:/var/run/docker.sock europe-docker.pkg.dev/pryzm-zone/core/pryzm-feeder:0.3.4