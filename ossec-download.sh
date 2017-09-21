#!/usr/bin/env bash

# Downloads OSSECS
# Tested:
#   Ubuntu 16.04

echo "Download OSSEC"
mkdir /opt/ossec
wget -U ossec https://bintray.com/artifact/download/ossec/ossec-hids/ossec-hids-2.8.3.tar.gz
wget -U ossec https://raw.githubusercontent.com/ossec/ossec-docs/master/docs/whatsnew/checksums/2.8.3/ossec-hids-2.8.3.tar.gz.sha256

# Verify proper download
check=$(sha256sum -c  ossec-hids-2.8.3.tar.gz.sha256 ossec-hids-2.8.3.tar.gz | grep "OK")
if [[ $check != *"OK"* ]]; then
    echo "sha256 check failed!"
    rm ossec-hids-*.tar.gz
    exit 1;
fi

# Extract and clean up
tar -zxvf ossec-hids-*.tar.gz -C /opt/ossec --strip-components=1
rm ossec-hids-*.tar.gz ossec-hids-*.tar.gz.sha256

if [ -f ossec.conf ]; then
    mv ossec.conf /var/ossec/etc/ossec.conf
else
    echo "ossec.conf not found"
fi
