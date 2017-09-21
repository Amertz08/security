#!/usr/bin/env bash

# Removes all ssh keys
# Tested:
#   Ubuntu 16.04

for X in $(cut -f6 -d ':' /etc/passwd | sort | uniq); do
    if [ -s "${X}/.ssh/authorized_keys" ]; then
        echo "### ${X}: "
        rm ${X}/.ssh/authorized_keys
        touch ${X}/.ssh/authorized_keys
    else
        echo "$X has no key file"
    fi
done
