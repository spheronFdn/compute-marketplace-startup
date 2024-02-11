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

WORKDIR /home/pryzm

# Install Go
RUN rm -rf /usr/local/go && \
    curl -Ls https://go.dev/dl/go1.20.3.linux-amd64.tar.gz | tar -xzf - -C /usr/local && \
    echo 'export PATH=$PATH:/usr/local/go/bin' >> $HOME/.profile && \
    echo 'export PATH=$PATH:$HOME/go/bin' >> $HOME/.profile && \
    . $HOME/.profile

# Download and prepare pryzm binaries
RUN wget https://storage.googleapis.com/pryzm-zone/core/0.11.1/pryzmd-0.11.1-linux-amd64 && \
    mv pryzmd-0.11.1-linux-amd64 pryzmd && \
    chmod +x pryzmd && \
    mkdir -p $HOME/.pryzm/cosmovisor/genesis/bin && \
    mv pryzmd $HOME/.pryzm/cosmovisor/genesis/bin/

# Install Cosmovisor
RUN /usr/local/go/bin/go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@v1.5.0

# Copy the setup scripts and configuration files into the container
COPY setup_node.sh /home/pryzm/setup_node.sh
COPY start_node.sh /home/pryzm/start_node.sh
# COPY pryzm.service /etc/systemd/system/pryzm.service

# Make scripts executable
RUN chmod +x /home/pryzm/setup_node.sh /home/pryzm/start_node.sh

# Set the entrypoint to the start script
ENTRYPOINT ["/home/pryzm/start_node.sh"]
