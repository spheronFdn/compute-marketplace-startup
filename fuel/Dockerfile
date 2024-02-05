# Use the official Rust image as the base
FROM rust:latest

# Set the working directory in the Docker container
WORKDIR /usr/src/fuel-node

# Install curl and other dependencies (if necessary)
RUN apt-get update && apt-get install -y curl

# Install the Fuel toolchain
# Modify the PATH environment variable to include the Fuel toolchain's binary directory
RUN curl --proto '=https' --tlsv1.2 -sSf https://install.fuel.network/fuelup-init.sh | sh && \
    echo 'export PATH="${HOME}/.fuelup/bin:${PATH}"' >> $HOME/.bashrc && \
    . $HOME/.bashrc && \
    /root/.fuelup/bin/fuelup toolchain install beta-4 && \
    /root/.fuelup/bin/fuelup default beta-4

# Download the chainConfig.json file from the provided URL
RUN curl -L -o chainConfig.json https://github.com/FuelLabs/fuel-core/blob/v0.20.4/deployment/scripts/chainspec/beta_chainspec.json?raw=true

# Expose ports for the node
EXPOSE 4000 30333

# Use ENTRYPOINT to run the fuel-core
ENTRYPOINT ["/bin/bash", "-c", "source $HOME/.bashrc && fuel-core run --service-name $SERVICE_NAME --keypair $P2P_SECRET --relayer $RPC_ENDPOINT --ip 0.0.0.0 --port 4000 --peering_port 30333 --db-path  ~/.fuel_beta4 --chain ./chainConfig.json --utxo-validation --poa-instant false --network beta-4 --enable-p2p --min-gas-price 1 --max_block_size 18874368  --max_transmit_size 18874368 --bootstrap_nodes /dns4/p2p-beta-4.fuel.network/tcp/30333/p2p/16Uiu2HAm3xjsqASZ68KpaJPkPCMUiMgquhjyDHtxcVxVdFkMgRFf,/dns4/p2p-beta-4.fuel.network/tcp/30334/p2p/16Uiu2HAmJyoJ2HrtPRdBALMT8fs5Q25xVj57gZj5s6G6dzbHypoS --sync_max_get_header 100 --sync_max_get_txns 100 --relayer-v2-listening-contracts 0x03f2901Db5723639978deBed3aBA66d4EA03aF73 --relayer-da-finalization 4 --relayer-da-deploy-height 4111672 --relayer-log-page-size 2000"]
