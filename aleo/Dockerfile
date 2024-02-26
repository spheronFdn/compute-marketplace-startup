# Use Ubuntu as the base image
FROM ubuntu:latest

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install essential components
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y screen git curl build-essential

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Clone snarkOS repository
RUN git clone https://github.com/AleoHQ/snarkOS.git --depth 1

# Install dependencies and snarkOS
WORKDIR /snarkOS
RUN ./build_ubuntu.sh && \
    cargo install --path .

# Copy the entry point script into the container
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]