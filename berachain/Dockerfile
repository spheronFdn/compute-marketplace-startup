# Use an official Ubuntu base image
FROM ubuntu:latest

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Run updates and install dependencies
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y git make screen jq wget curl

# Download and install Go
RUN wget https://golang.org/dl/go1.21.4.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.21.4.linux-amd64.tar.gz

# Add Go to PATH
ENV PATH="/root/.foundry/bin:${PATH}"

# Download and execute the script from Foundry Paradigm, and install Foundry
RUN curl -L https://foundry.paradigm.xyz | bash && \
    /root/.foundry/bin/foundryup

# Clone the Polaris repository
RUN cd /root && \
    git clone https://github.com/berachain/polaris && \
    cd polaris && \
    git checkout main

# Expose ports if necessary (depends on the application)
# EXPOSE <port>

# Set the working directory to Polaris
# WORKDIR /root/polaris

# Command to start the Polaris node
CMD ["make", "start"]
