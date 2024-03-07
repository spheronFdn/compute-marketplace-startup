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
RUN curl -L https://go.dev/dl/go1.21.4.linux-amd64.tar.gz | tar -xzf - -C /usr/local

# Correctly set the PATH to include both Go binaries and workspace binaries
ENV PATH="/usr/local/go/bin:/root/go/bin:${PATH}"

RUN curl -L https://foundry.paradigm.xyz | bash && \
    . /root/.bashrc && \
    foundryup

# Clone Babylon repository and checkout the specific version
RUN git clone https://github.com/berachain/polaris && \
    cd polaris && \
    git checkout main

# Set the entrypoint to the start script
CMD ["make", "start"]
