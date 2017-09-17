FROM ubuntu:16.04

RUN apt update \
    && apt install wget build-essential ufw -y \
    && rm -rf /var/lib/apt/lists/*

ADD . /opt/scripts
WORKDIR /opt/scripts
