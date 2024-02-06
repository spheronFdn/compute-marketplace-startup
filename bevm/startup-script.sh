#!/bin/bash

# Escape characters that might interfere with sed operations
NODE_NAME_ESCAPED=$(echo $NODE_NAME | sed 's/[&/\]/\\&/g')

# Replace "Your-Node-Name" in config.json with the actual NODE_NAME
cat /config.json | while read line; do echo $line | sed "s/Your-Node-Name/$NODE_NAME_ESCAPED/g"; done > /config.tmp && mv /config.tmp /config.json

