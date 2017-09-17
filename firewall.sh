#!/usr/bin/env bash

init () {
    echo "Initial config"
    ufw default allow outgoing
    ufw default deny incoming
    allow ssh
    ufw enable
}

allow () {
    ufw allow $1
}


init
echo "Done"
