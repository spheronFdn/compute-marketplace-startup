# Use golang as the base image
FROM golang:1.20.12

# Set the working directory in the container
WORKDIR /usr/src/app

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends git make

# Clone the StratisEVM repository
RUN git clone https://github.com/stratisproject/StratisEVM --recurse-submodules

# Build Geth from Source
WORKDIR /usr/src/app/StratisEVM/go-ethereum
RUN go build -o=/usr/local/bin/geth ./cmd/geth

# Build Prysm from Source
WORKDIR /usr/src/app/StratisEVM/prysm-stratis
RUN go build -o=/usr/local/bin/beacon-chain ./cmd/beacon-chain

# Go back to the main directory
WORKDIR /usr/src/app/StratisEVM

# Initialize GETH
RUN /usr/local/bin/geth --datadir=data/testnet/geth init configs/testnet/genesis.json

# Expose Geth and Prysm ports
EXPOSE 8545 30303 4000 13000 12000/udp

# Add a script to start both Geth and Pryzm
COPY start-services.sh /usr/src/app/StratisEVM/start-services.sh
RUN chmod +x /usr/src/app/StratisEVM/start-services.sh

ENTRYPOINT ["/usr/src/app/StratisEVM/start-services.sh"]
