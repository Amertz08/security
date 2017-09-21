#!/usr/bin/env bash

# Functions to run as root to lock down system


lkfs() {
    echo "Lock down fs"
    echo "none /run/shm tmpfs rw,noexec,nosuid,nodev 0 0" >> /etc/fstab
}

nosudo() {
    echo "Denying su to non-admins"
    dpkg-statoverride --update --add root sudo 4750 /bin/su
}

lkh() {
    echo "Locking home for $1"
    chmod 0750 /home/$1
}

ucreate() {
    if [ -z "$1" ]; then
        echo "No username provided"
    else
        useradd $1 -m
        passwd $1
        usermod -aG sudo $1
        echo "Created user: $1"
    fi
}

sshconf() {
    echo "Moving SSH config"
    mv sshd_config.txt /etc/ssh/sshd_config
    service ssh restart
}

main() {
    echo "Enter new username:"
    read uname

    if [ $uname ]; then
        ucreate $uname
        lkh $uname
        lkfs
        nosudo
        sshconf
    else
        echo "No username provided"
    fi
}

main
