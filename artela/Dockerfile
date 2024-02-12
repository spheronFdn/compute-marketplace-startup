# Use Ubuntu as the base image
FROM ubuntu:20.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update -qq && \
    apt-get install -yqq curl git jq lz4 build-essential fail2ban ufw && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Go
RUN curl -Ls https://go.dev/dl/go1.20.7.linux-amd64.tar.gz | tar -xzf - -C /usr/local
ENV PATH="${PATH}:/usr/local/go/bin"

WORKDIR /home/artela

# Clone and build Artela project
RUN git clone https://github.com/artela-network/artela && \
    cd artela && \
    git checkout v0.4.7-rc6 && \
    make build

# Prepare binaries for cosmovisor
RUN mkdir -p .artelad/cosmovisor/genesis/bin && \
    mv artela/build/artelad .artelad/cosmovisor/genesis/bin/ && \
    rm -rf artela/build

# Install cosmovisor
RUN go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@v1.5.0

# Expose ports (add other ports if necessary)
EXPOSE 23456 23457 23458 23460 23466 23417 23480 23490 23491

# Set environment variables
ENV DAEMON_HOME=/home/artela/.artelad
ENV DAEMON_NAME=artelad
ENV MONIKER=your-moniker-name
ENV UNSAFE_SKIP_BACKUP=true

# Add entrypoint script
COPY entrypoint.sh /home/artela/entrypoint.sh
RUN sudo chmod +x /home/artela/entrypoint.sh

ENTRYPOINT ["/home/artela/entrypoint.sh"]
