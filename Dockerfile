FROM ubuntu:16.04

RUN apt update \
    && apt install wget build-essential -y \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -ms /bin/bash steve
USER steve

WORKDIR /home/steve
ADD . .

EXPOSE 1514
