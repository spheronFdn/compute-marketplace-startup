# Use Ubuntu as the base image
FROM ubuntu:20.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Update and install dependencies
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y curl jq

# Install nibid
RUN curl -s https://get.nibiru.fi/@v1.0.0! | bash

# Setting environment variables
ENV HOME=/root
ENV NETWORK=nibiru-testnet-1

# Copy the entrypoint script into the container
COPY entrypoint.sh /entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /entrypoint.sh

# Use the entrypoint script to initialize and start nibid
ENTRYPOINT ["/entrypoint.sh"]
