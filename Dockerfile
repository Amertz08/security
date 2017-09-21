FROM ubuntu:16.04

RUN apt update \
    && apt install sudo wget build-essential -y \
    && rm -rf /var/lib/apt/lists/*

ADD . /opt/scripts
WORKDIR /opt/scripts
