FROM ubuntu:latest
ENV TZ=Asia/Kolkata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && apt-get install sudo wget curl tar zip unzip jq goxkcdpwgen  -y
RUN apt-get upgrade -y
RUN sudo apt install build-essential git make gcc nvme-cli pkg-config libssl-dev libleveldb-dev clang bsdmainutils ncdu libleveldb-dev -y