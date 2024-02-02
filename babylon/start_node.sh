#!/bin/bash

# Ensure environment variables are set for Cosmovisor
export DAEMON_HOME=$HOME/.babylond
export DAEMON_NAME=babylond
export UNSAFE_SKIP_BACKUP=true
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:$HOME/.babylond/cosmovisor/current/bin:$PATH

# Start the babylon node through Cosmovisor
exec cosmovisor run start
