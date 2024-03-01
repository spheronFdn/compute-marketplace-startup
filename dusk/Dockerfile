# Use an official base image that has curl and bash installed
FROM ubuntu:latest

# Avoid prompts from apt to hang the build
ARG DEBIAN_FRONTEND=noninteractive

# Install any dependencies your script might require
RUN apt-get update && apt-get install -y \
    curl sudo unzip jq net-tools logrotate ufw \
    && rm -rf /var/lib/apt/lists/*

# Install systemd
RUN apt-get update && apt-get install -y systemd systemd-sysv

# Remove unnecessary systemd services.
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
    rm -f /lib/systemd/system/multi-user.target.wants/*;\
    rm -f /etc/systemd/system/*.wants/*;\
    rm -f /lib/systemd/system/local-fs.target.wants/*; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -f /lib/systemd/system/basic.target.wants/*;\
    rm -f /lib/systemd/system/anaconda.target.wants/*;

# Allow systemd to run in a container
ENV container docker

# Download and execute the itn-installer script directly without sudo
RUN curl --proto '=https' --tlsv1.2 -sSfL https://github.com/dusk-network/itn-installer/releases/download/v0.1.0/itn-installer.sh | sudo sh


ADD start_node.sh /start_node.sh
RUN chmod +x /start_node.sh

# Expose ports 9000 and 8080
EXPOSE 9000 8080

# The container does not need a specific command to run, but you could use a command to keep it running, such as:
ENTRYPOINT ["/start_node.sh"]
