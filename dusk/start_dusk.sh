#!/bin/bash

# Mimic Environment Variables
export RUST_BACKTRACE=full
export RUSK_PROFILE_PATH=/opt/dusk/rusk

# Ensure the working directory is correct
cd /opt/dusk

# ExecStartPre commands
/opt/dusk/bin/rusk recovery-keys >> /var/log/rusk_recovery.log
/opt/dusk/bin/rusk recovery-state >> /var/log/rusk_recovery.log
/opt/dusk/bin/check_consensus_keys.sh
/opt/dusk/bin/detect_ips.sh > /opt/dusk/services/rusk.conf.default
chown -R dusk:dusk /opt/dusk/rusk/state

# Load environment files if they exist
if [ -f /opt/dusk/services/rusk.conf.default ]; then
    source /opt/dusk/services/rusk.conf.default
fi

if [ -f /opt/dusk/services/rusk.conf.user ]; then
    source /opt/dusk/services/rusk.conf.user
fi

if [ -f /opt/dusk/services/dusk.conf ]; then
    source /opt/dusk/services/dusk.conf
fi

# ExecStart command with output redirection
/opt/dusk/bin/rusk --config /opt/dusk/conf/rusk.toml --kadcast-bootstrap bootstrap1.testnet.dusk.network:9000 --kadcast-bootstrap bootstrap2.testnet.dusk.network:9000 >> /var/log/rusk.log 2>> /var/log/rusk.err &

# Keep the script running to avoid container exit
wait
