#!/usr/bin/env bash

# Helps manage UFW
# Tested:
#   Ubuntu 16.04
#
# To make executable:
#   1) chmod +x firewall.sh
#   2) mv firewall.sh /usr/local/bin/fw


init () {
    checkinstall
    echo "Initial config"
    ufw default allow outgoing
    ufw default deny incoming
    allow ssh
    ufw enable
    echo "Firewall enabled"
}

checkinstall () {
    command -v ufw >/dev/null 2>&1 || { echo >&2 "UFW not installed. Installing..."; apt update && apt install -y ufw; }
}

cycle () {
    ufw disable
    ufw enable
    echo "Firewall restarted"
}

status () {
    ufw status numbered
}

delete () {
    echo "Deleting " $@
    ufw delete $@
}

allow () {
    echo "Adding allow for " $@
    ufw allow $@
}

deny () {
    echo "Adding deny for " $@
    ufw deny $@
}

aip () {
    echo "Allowing from " $@
    ufw allow from $@
}

dip () {
    echo "Denying from " $@
    ufw deny from $@
}
