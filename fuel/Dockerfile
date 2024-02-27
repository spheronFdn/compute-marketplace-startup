# Use the official Rust image as the base
FROM rust:latest

# Set the working directory in the Docker container
WORKDIR /usr/src/fuel-node

# Install curl and other dependencies (if necessary)
RUN apt-get update && apt-get install -y curl jq

# Install the Fuel toolchain
RUN curl https://install.fuel.network | sh && \
    echo 'export PATH="${HOME}/.fuelup/bin:${PATH}"' >> $HOME/.bashrc && \
    . $HOME/.bashrc

# Download the chainConfig.json file from the provided URL
RUN curl -L -o chainConfig.json https://github.com/FuelLabs/fuel-core/blob/v0.22.0/deployment/scripts/chainspec/beta_chainspec.json

ADD ./peering-setup.sh /peering-setup.sh
RUN chmod +x /peering-setup.sh

# Expose ports for the node
EXPOSE 4000 30333

# Use ENTRYPOINT to run the fuel-core
ENTRYPOINT ["/bin/bash", "-c", "source $HOME/.bashrc && sh /peering-setup.sh && P2P_SECRET=$(cat /tmp/p2p_secret.txt) && fuel-core run --service-name $SERVICE_NAME --keypair $P2P_SECRET --relayer $ETH_RPC_ENDPOINT --ip 0.0.0.0 --port 4000 --peering-port 30333 --db-path  ~/.fuel_beta5 --chain ./chainConfig.json --utxo-validation --poa-instant false --enable-p2p --min-gas-price 1 --max-block-size 18874368  --max-transmit-size 18874368 --reserved-nodes /dns4/p2p-beta-5.fuel.network/tcp/30333/p2p/16Uiu2HAmSMqLSibvGCvg8EFLrpnmrXw1GZ2ADX3U2c9ttQSvFtZX,/dns4/p2p-beta-5.fuel.network/tcp/30334/p2p/16Uiu2HAmVUHZ3Yimoh4fBbFqAb3AC4QR1cyo8bUF4qyi8eiUjpVP --sync-header-batch-size 100 --enable-relayer --relayer-v2-listening-contracts 0x557c5cE22F877d975C2cB13D0a961a182d740fD5 --relayer-da-deploy-height 4867877 --relayer-log-page-size 2000"]

# /bin/bash
# -c
# source $HOME/.bashrc && apt upgrade -y && apt install jq curl -y && curl -sSL https://raw.githubusercontent.com/spheronFdn/compute-marketplace-startup/main/fuel/peering-setup.sh -o ./peering-setup.sh && chmod +x ./peering-setup.sh && sh ./peering-setup.sh && fuel-core run --service-name $SERVICE_NAME --keypair $P2P_SECRET --relayer $RPC_ENDPOINT --ip 0.0.0.0 --port 4000 --peering_port 30333 --db-path  ~/.fuel_beta4 --chain ./chainConfig.json --utxo-validation --poa-instant false --network beta-4 --enable-p2p --min-gas-price 1 --max_block_size 18874368  --max_transmit_size 18874368 --bootstrap_nodes /dns4/p2p-beta-4.fuel.network/tcp/30333/p2p/16Uiu2HAm3xjsqASZ68KpaJPkPCMUiMgquhjyDHtxcVxVdFkMgRFf,/dns4/p2p-beta-4.fuel.network/tcp/30334/p2p/16Uiu2HAmJyoJ2HrtPRdBALMT8fs5Q25xVj57gZj5s6G6dzbHypoS --sync_max_get_header 100 --sync_max_get_txns 100 --relayer-v2-listening-contracts 0x03f2901Db5723639978deBed3aBA66d4EA03aF73 --relayer-da-finalization 4 --relayer-da-deploy-height 4111672 --relayer-log-page-size 2000