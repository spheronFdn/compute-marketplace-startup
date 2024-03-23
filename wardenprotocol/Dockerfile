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
RUN curl -L https://go.dev/dl/go1.21.2.linux-amd64.tar.gz | tar -xzf - -C /usr/local 

# Set environment variable for Go
ENV PATH="/usr/local/go/bin:${PATH}"

# Clone and build the wardend binary
RUN git clone --depth 1 --branch v0.1.0 https://github.com/warden-protocol/wardenprotocol/ && \
    cd wardenprotocol/warden/cmd/wardend && \
    go build && \
    mv wardend /usr/local/bin/

# Copy the setup scripts and configuration files into the container
COPY setup_node.sh /usr/local/bin/setup_node.sh
COPY start_node.sh /usr/local/bin/start_node.sh

# Make scripts executable
RUN chmod +x /usr/local/bin/setup_node.sh /usr/local/bin/start_node.sh

# Expose ports
EXPOSE 26656 26657 1317 9090

# Set the entrypoint to the start script
ENTRYPOINT ["/usr/local/bin/start_node.sh"]
