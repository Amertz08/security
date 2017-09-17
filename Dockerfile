FROM ubuntu:16.04

RUN apt update \
    && apt install wget build-essential -y \
    && rm -rf /var/lib/apt/lists/*

ADD . /scripts
WORKDIR /scripts
EXPOSE 1514
