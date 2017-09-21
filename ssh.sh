#!/usr/bin/env bash

# Deletes authorized_keys file for all users
dall() {
    for X in $(cut -f6 -d ':' /etc/passwd | sort | uniq); do
        if [ -s "${X}/.ssh/authorized_keys" ]; then
            echo "### ${X}: "
            rm ${X}/.ssh/authorized_keys
            touch ${X}/.ssh/authorized_keys
        else
            echo "$X has no key file"
        fi
    done
}

# Moves SSH config file and restarts service
mvconf() {
    echo "Moving SSH config"
    mv ./etc/sshd_config.txt /etc/ssh/sshd_config
    service ssh restart
}