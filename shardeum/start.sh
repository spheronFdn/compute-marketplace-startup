#!/bin/bash

# Load environment variables
SHMEXT=${SHMEXT}
SHMINT=${SHMINT}

# Replace placeholders with environment variable values
envsubst '${SHMINT},${SHMEXT}' < nginx.conf.template > nginx.conf

# Start Nginx with the new config
nginx -c $(pwd)/nginx.conf
