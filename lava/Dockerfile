# Use a base image that includes Ubuntu with necessary tools
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

# Clone and build the lava project
RUN cd $HOME && \
    git clone https://github.com/lavanet/lava.git && \
    cd lava && \
    git checkout v0.32.0 && \
    export LAVA_BINARY=lavad && \
    make build && \
    mkdir -p /root/.lava/cosmovisor/genesis/bin && \
    mv build/lavad /root/.lava/cosmovisor/genesis/bin/ && \
    rm -rf build

# Create symlinks for the application
RUN ln -s /root/.lava/cosmovisor/genesis /root/.lava/cosmovisor/current -f && \
    ln -s /root/.lava/cosmovisor/current/bin/lavad /usr/local/bin/lavad -f

# Install Cosmovisor
RUN go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@latest

# Expose necessary ports (replace with actual ports used by your application)
EXPOSE 20457 20456 20458 20460 20466 20417 20480 20490 20491 20445 20446 20465

# Copy the setup scripts and configuration files into the container
COPY setup_node.sh /usr/local/bin/setup_node.sh
COPY start_node.sh /usr/local/bin/start_node.sh

# Make scripts executable
RUN chmod +x /usr/local/bin/setup_node.sh /usr/local/bin/start_node.sh

# Set the entrypoint to the start script
ENTRYPOINT ["/usr/local/bin/start_node.sh"]
