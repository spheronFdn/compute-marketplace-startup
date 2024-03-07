# Use Ubuntu as the base image
FROM ubuntu:20.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Set work directory
WORKDIR /root

# Install dependencies
RUN apt-get update && \
    apt-get install -y curl git jq lz4 wget build-essential && \
    rm -rf /var/lib/apt/lists/*

# Install Go
RUN curl -L https://go.dev/dl/go1.21.6.linux-amd64.tar.gz | tar -xzf - -C /usr/local

# Correctly set the PATH to include both Go binaries and workspace binaries
ENV PATH="/usr/local/go/bin:/root/go/bin:${PATH}"

# Clone Babylon repository and checkout the specific version
RUN git clone https://github.com/sideprotocol/sidechain.git && \
    cd sidechain && \
    git checkout v0.6.0 && \
    make build

# Prepare binaries for Cosmovisor
RUN mkdir -p /root/.side/cosmovisor/genesis/bin && \
    mv /root/side/build/sided /root/.side/cosmovisor/genesis/bin/ && \
    rm -rf /root/side/build

# Create symlinks for the application
RUN ln -s /root/.side/cosmovisor/genesis /root/.side/cosmovisor/current -f && \
    ln -s /root/.side/cosmovisor/current/bin/sided /usr/local/bin/sided -f

# Install Cosmovisor
RUN go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@v1.5.0

# Copy the setup scripts and configuration files into the container
COPY setup_node.sh /usr/local/bin/setup_node.sh
COPY start_node.sh /usr/local/bin/start_node.sh

# Make scripts executable
RUN chmod +x /usr/local/bin/setup_node.sh /usr/local/bin/start_node.sh

# Set the entrypoint to the start script
ENTRYPOINT ["/usr/local/bin/start_node.sh"]
