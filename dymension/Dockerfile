# Use Ubuntu as the base image
FROM ubuntu:20.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Set work directory
WORKDIR /root

# Install dependencies
RUN apt-get update && \
    apt-get install -y curl git jq lz4 build-essential && \
    rm -rf /var/lib/apt/lists/*

# Install Go
RUN curl -L https://go.dev/dl/go1.20.12.linux-amd64.tar.gz | tar -xzf - -C /usr/local

# Correctly set the PATH to include both Go binaries and workspace binaries
ENV PATH="/usr/local/go/bin:/root/go/bin:${PATH}"


# Clone Babylon repository and checkout the specific version
RUN git clone https://github.com/dymensionxyz/dymension.git && \
    cd dymension && \
    git checkout v3.0.0 && \
    make install

# Prepare binaries for Cosmovisor
# RUN mkdir -p /root/.babylond/cosmovisor/genesis/bin && \
#     mv /root/babylon/build/babylond /root/.babylond/cosmovisor/genesis/bin/ && \
#     rm -rf /root/babylon/build

# # Create symlinks for the application
# RUN ln -s /root/.babylond/cosmovisor/genesis /root/.babylond/cosmovisor/current -f && \
#     ln -s /root/.babylond/cosmovisor/current/bin/babylond /usr/local/bin/babylond -f

# # Install Cosmovisor
# RUN go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@latest

# Copy the setup scripts and configuration files into the container
COPY setup_node.sh /usr/local/bin/setup_node.sh
COPY start_node.sh /usr/local/bin/start_node.sh

# Make scripts executable
RUN chmod +x /usr/local/bin/setup_node.sh /usr/local/bin/start_node.sh

EXPOSE 26656 26657 1317 9090

# Set the entrypoint to the start script
ENTRYPOINT ["/usr/local/bin/start_node.sh"]
