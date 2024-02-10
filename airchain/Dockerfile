# Use Ubuntu as the base image
FROM ubuntu:20.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    wget \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install Go
RUN wget https://go.dev/dl/go1.21.0.linux-amd64.tar.gz \
    && tar -C /usr/local -xzf go1.21.0.linux-amd64.tar.gz \
    && rm go1.21.linux-amd64.tar.gz

# Set the Go path
ENV PATH="/usr/local/go/bin:${PATH}"

# Install Ignite
RUN wget https://github.com/ignite/cli/releases/download/v0.27.1/ignite_0.27.1_linux_amd64.tar.gz \
    && tar -xvf ignite_0.27.1_linux_amd64.tar.gz \
    && chmod +x ignite \
    && mv ignite /usr/local/bin \
    && rm ignite_0.27.1_linux_amd64.tar.gz

# Clone and setup the Junction Node
RUN git clone https://github.com/airchains-network/junction.git \
    && cd junction \
    && git checkout v0.0.2-beta \
    && ignite chain build

# Copy startup script
COPY startup.sh /startup.sh
RUN chmod +x /startup.sh

# Expose the necessary ports
EXPOSE 1317 26656 26657

# Command to run the startup script
CMD ["/startup.sh"]
