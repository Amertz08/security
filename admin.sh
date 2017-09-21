#!/usr/bin/env bash

# Functions to run as root to lock down system


lkfs() {
    echo "Lock down fs"
    echo "none /run/shm tmpfs defaults,ro 0 0" >> /etc/fstab
    cat /etc/fstab
}

nosudo() {
    echo "Denying su to non-admins"
    dpkg-statoverride --update --add root sudo 4750 /bin/su
}

lkh() {
    echo "Locking home for $1"
    chmod 0750 /home/$1
}

lsh() {
    ls /home
}

ucreate() {
    if [ -z "$1" ]; then
        echo "No username provided"
    else
        useradd $1 -m
        passwd $1
        echo "Created user: $1"
    fi
}

case $1 in
    (lkfs)
        lkfs
        ;;
    (ucreate)
        ucreate $2
        ;;
    (lkh)
        lkh $2
        ;;
    (lsh)
        lsh
        ;;
    (nosudo)
        nosudo
        ;;
esac
