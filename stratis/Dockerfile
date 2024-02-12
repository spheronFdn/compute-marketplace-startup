# Use golang as the base image
FROM golang:1.21

# Set the working directory in the container
WORKDIR /usr/src/app

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends git make && \
    apt-get install -y curl tar unzip && \
    rm -rf /var/lib/apt/lists/*

# Clone the StratisEVM repository
RUN git clone https://github.com/stratisproject/StratisEVM --recurse-submodules

# Build Geth from Source
# WORKDIR /usr/src/app/StratisEVM/go-stratis
# RUN go build -o=/usr/local/bin/geth ./cmd/geth
RUN curl -L https://github.com/stratisproject/go-stratis/releases/download/0.1.0/geth-linux-amd64-fabe6d6.tar.gz | tar -xzf - -C /usr/local/bin/ && \
    chmod +x /usr/local/bin/geth

# Build Prysm from Source
# WORKDIR /usr/src/app/StratisEVM/prysm-stratis
# RUN go build -o=/usr/local/bin/beacon-chain ./cmd/beacon-chain
RUN curl -L https://github.com/stratisproject/prysm-stratis/releases/download/0.1.0/beacon-chain-linux-amd64-1ffa421.tar.gz | tar -xzf - -C /usr/local/bin/ && \
    chmod +x /usr/local/bin/beacon-chain

RUN curl -L https://github.com/stratisproject/prysm-stratis/releases/download/0.1.0/client-stats-linux-amd64-1ffa421.tar.gz | tar -xzf - -C /usr/local/bin/ && \
    chmod +x /usr/local/bin/client-stats

RUN curl -L https://github.com/stratisproject/prysm-stratis/releases/download/0.1.0/prysmctl-linux-amd64-1ffa421.tar.gz | tar -xzf - -C /usr/local/bin/ && \
    chmod +x /usr/local/bin/prysmctl

RUN curl -L https://github.com/stratisproject/prysm-stratis/releases/download/0.1.0/validator-linux-amd64-1ffa421.tar.gz | tar -xzf - -C /usr/local/bin/ && \
    chmod +x /usr/local/bin/validator


# Install staking cli
RUN curl -L https://github.com/stratisproject/staking-deposit-cli/releases/download/0.1.0/staking-deposit-cli-linux-amd64.zip -o staking-deposit-cli.zip && \
    unzip staking-deposit-cli.zip -d /tmp && \
    rm staking-deposit-cli.zip

# List contents of /tmp to confirm the .tar.gz file's presence
RUN ls -al /tmp

# Extract the TAR file from the unzipped content to /usr/local/bin and make it executable
RUN find /tmp -name "staking-deposit-cli-linux-amd64.tar.gz" -exec tar -xzf {} -C /usr/local/bin/ \; && \
    chmod +x /usr/local/bin/deposit

# Clean up the temporary files
RUN rm -rf /tmp/*

# Go back to the main directory
WORKDIR /usr/src/app/StratisEVM

# Initialize GETH
RUN /usr/local/bin/geth --datadir=data/testnet/geth init configs/testnet/genesis.json

# Expose Geth and Prysm ports
EXPOSE 8545 30303 4000 13000 12000

# Add a script to start both Geth and Pryzm
COPY start-services.sh /usr/src/app/StratisEVM/start-services.sh
RUN chmod +x /usr/src/app/StratisEVM/start-services.sh

ENTRYPOINT ["/usr/src/app/StratisEVM/start-services.sh"]
