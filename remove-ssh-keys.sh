#!/usr/bin/env bash

# Removes all ssh keys
# Tested:
#   Ubuntu 16.04

KEY_FILE=~/.ssh/authorized_keys

echo "Key file:" $KEY_FILE

if [ ! -f $KEY_FILE ]; then
    echo "authorized_keys file not found"
else
    rm $KEY_FILE
    touch $KEY_FILE
    echo "Keys cleared"
fi
