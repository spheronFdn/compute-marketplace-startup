#!/bin/bash

# Mimic ExecStartPre commands
/opt/dusk/bin/rusk recovery-keys >> /var/log/rusk_recovery.log
/opt/dusk/bin/rusk recovery-state >> /var/log/rusk_recovery.log
/opt/dusk/bin/check_consensus_keys.sh
/opt/dusk/bin/detect_ips.sh > /opt/dusk/services/rusk.conf.default
chown -R dusk /opt/dusk/rusk/state

# Start the rusk process (mimic ExecStart)
/opt/dusk/bin/rusk --config /opt/dusk/conf/rusk.toml --kadcast-bootstrap bootstrap1.testnet.dusk.network:9000 --kadcast-bootstrap bootstrap2.testnet.dusk.network:9000 &
