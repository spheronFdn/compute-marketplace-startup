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
RUN curl -L https://go.dev/dl/go1.22.0.linux-amd64.tar.gz | tar -xzf - -C /usr/local

# Correctly set the PATH to include both Go binaries and workspace binaries
ENV PATH="/usr/local/go/bin:/root/go/bin:${PATH}"

# Clone Babylon repository and checkout the specific version
RUN git clone https://github.com/babylonchain/babylon.git && \
    cd babylon && \
    git checkout v0.8.3 && \
    make build

# Prepare binaries for Cosmovisor
RUN mkdir -p /root/.babylond/cosmovisor/genesis/bin && \
    mv /root/babylon/build/babylond /root/.babylond/cosmovisor/genesis/bin/ && \
    rm -rf /root/babylon/build

# Create symlinks for the application
RUN ln -s /root/.babylond/cosmovisor/genesis /root/.babylond/cosmovisor/current -f && \
    ln -s /root/.babylond/cosmovisor/current/bin/babylond /usr/local/bin/babylond -f

# Install Cosmovisor
RUN go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@v1.5.0

# Copy the setup scripts and configuration files into the container
COPY setup_node.sh /usr/local/bin/setup_node.sh
COPY start_node.sh /usr/local/bin/start_node.sh

# Make scripts executable
RUN chmod +x /usr/local/bin/setup_node.sh /usr/local/bin/start_node.sh

# Set the entrypoint to the start script
ENTRYPOINT ["/usr/local/bin/start_node.sh"]
