#!/usr/bin/env bash

# Downloads and installs Snort
# Tested:
#   Ubuntu 16.04

echo "Installing prereqs"
apt update
apt install -y gcc libpcre3-dev zlib1g-dev libpcap-dev openssl \
    libssl-dev libnghttp2-dev libdumbnet-dev bison flex libdnet

echo "Downloading DAQ"
mkdir /opt/daq
wget https://www.snort.org/downloads/snort/daq-2.0.6.tar.gz
tar -xvzf daq-*.tar.gz -C /opt/daq --strip-components=1
rm daq-*.tar.gz
/opt/daq/configure && make && make install
echo "DAQ downloaded and installed"

echo "Downloading Snort"
mkdir /opt/snort
wget https://www.snort.org/downloads/snort/snort-2.9.9.0.tar.gz
tar -xvzf snort-*.tar.gz -C /opt/snort --strip-components=1
rm snort-*.tar.gz
/opt/snort/configure --enable-sourcefire && make && make install
echo "Snort downloaded and installed"

echo "Creating Snort user"
groupadd snort
useradd snort -r -s /sbin/nologin -c SNORT_IDS -g snort

echo "Creating directories"
mkdir -p /etc/snort/rules
mkdir /var/log/snort
mkdir /var/local/lib/snort_dynamicrules
chmod -R 5775 /etc/snort
chmod -R 5775 /var/log/snort
chmod -R 5775 /usr/local/lib/snort_dynamicrules
chown -R snort:snort /etc/snort
chown -R snort:snort /var/log/snort
chown -R snort:snort /usr/local/lib/snort_dynamicrules

echo "Creating rules files"
touch /etc/snort/rules/white_list.rules
touch /etc/snort/rules/black_list.rules
touch /etc/snort/rules/local.rules

echo "Moving config files"
cp /opt/snort/etc/*.conf* /etc/snort
cp /opt/snort/etc/*.map /etc/snort

echo "Getting community rules"
wget https://www.snort.org/rules/community -O community.tar.gz
tar -xzvf community.tar.gz
rm community.tar.gz
cp community-rules/* /etc/snort/rules

echo "DONE"