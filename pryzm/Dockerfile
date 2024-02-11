# Use Ubuntu as the base image
FROM ubuntu:20.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Set work directory
WORKDIR /root

# Install dependencies
RUN apt-get update -qq && \
    apt-get install -y curl git jq lz4 build-essential fail2ban ufw wget && \
    apt-get upgrade -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Go
RUN curl -L https://go.dev/dl/go1.20.12.linux-amd64.tar.gz | tar -xzf - -C /usr/local

# Correctly set the PATH to include both Go binaries and workspace binaries
ENV PATH="/usr/local/go/bin:/root/go/bin:${PATH}"


# Download and prepare pryzm binaries
RUN wget https://storage.googleapis.com/pryzm-zone/core/0.11.1/pryzmd-0.11.1-linux-amd64 && \
    mv pryzmd-0.11.1-linux-amd64 pryzmd && \
    chmod +x pryzmd && \
    mkdir -p $HOME/.pryzm/cosmovisor/genesis/bin && \
    mv pryzmd $HOME/.pryzm/cosmovisor/genesis/bin/

# Prepare binaries for Cosmovisor
RUN mkdir -p /root/.babylond/cosmovisor/genesis/bin && \
    mv /root/babylon/build/babylond /root/.babylond/cosmovisor/genesis/bin/ && \
    rm -rf /root/babylon/build

# Create symlinks for the application
RUN ln -s /root/.babylond/cosmovisor/genesis /root/.babylond/cosmovisor/current -f && \
    ln -s /root/.babylond/cosmovisor/current/bin/babylond /usr/local/bin/babylond -f

# Install Cosmovisor
RUN go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@latest

# Copy the setup scripts and configuration files into the container
COPY setup_node.sh /usr/local/bin/setup_node.sh
COPY start_node.sh /usr/local/bin/start_node.sh

# Make scripts executable
RUN chmod +x /usr/local/bin/setup_node.sh /usr/local/bin/start_node.sh

# Set the entrypoint to the start script
ENTRYPOINT ["/usr/local/bin/start_node.sh"]
