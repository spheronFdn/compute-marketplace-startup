# Use a base image that includes Ubuntu with necessary tools
FROM ubuntu:20.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Update and install dependencies
RUN apt-get update && \
    apt-get install -y curl git jq lz4 build-essential fail2ban ufw && \
    apt-get upgrade -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Go
ENV GOLANG_VERSION=1.20.10
RUN rm -rf /usr/local/go && \
    curl -Ls https://go.dev/dl/go${GOLANG_VERSION}.linux-amd64.tar.gz | tar -xzf - -C /usr/local && \
    echo 'export PATH=$PATH:/usr/local/go/bin' > /etc/profile.d/golang.sh && \
    echo 'export PATH=$PATH:$HOME/go/bin' >> $HOME/.profile

# Set environment variables needed for our image
ENV PATH="${PATH}:/usr/local/go/bin:$HOME/go/bin"
ENV MONIKER=your-moniker-name
ENV DAEMON_HOME=/root/.lava
ENV DAEMON_NAME=lavad
ENV UNSAFE_SKIP_BACKUP=true

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

# Install cosmovisor
RUN /usr/local/go/bin/go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@v1.5.0

# Prepare configuration and data
COPY setup.sh /setup.sh
RUN chmod +x /setup.sh && /setup.sh

# Expose necessary ports (replace with actual ports used by your application)
EXPOSE 20457 20456 20458 20460 20466 20417 20480 20490 20491 20445 20446 20465

# Command to run the application
CMD ["cosmovisor", "run", "start"]
