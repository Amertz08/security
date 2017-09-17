#!/usr/bin/env bash

# Helps manage UFW
# Tested:
#   Ubuntu 16.04

init () {
    checkinstall
    echo "Initial config"
    ufw default allow outgoing
    ufw default deny incoming
    allow ssh
    ufw enable
}

checkinstall () {
    command -v ufw >/dev/null 2>&1 || { echo >&2 "UFW not installed. Installing..."; apt update && apt install -y ufw; }
}

allow () {
    ufw allow $1
}


init
echo "Done"
