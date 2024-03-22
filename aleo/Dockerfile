# Use Ubuntu as the base image
FROM ubuntu:latest

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install essential components, including pkg-config, libssl-dev, clang, and libclang-dev
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y screen git curl build-essential pkg-config libssl-dev clang libclang-dev

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Clone snarkOS repository
RUN git clone https://github.com/AleoHQ/snarkOS.git --depth 1

# Install dependencies and snarkOS
WORKDIR /snarkOS
RUN ./build_ubuntu.sh && \
    cargo install --path .

EXPOSE 4130 4133 3033

# Copy the entry point script into the container
CMD ["tail", "-f", "/dev/null"]