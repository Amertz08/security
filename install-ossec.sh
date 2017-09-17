#!/usr/bin/env bash

echo "Install OSSEC"
wget -U ossec https://bintray.com/artifact/download/ossec/ossec-hids/ossec-hids-2.8.3.tar.gz
wget -U ossec https://raw.githubusercontent.com/ossec/ossec-docs/master/docs/whatsnew/checksums/2.8.3/ossec-hids-2.8.3.tar.gz.sha256
sha256sum -C  ossec-hids-2.8.3.tar.gz.sha256 ossec-hids-2.8.3.tar.gz
tar -zxvf ossec-hids-*.tar.gz
rm ossec-hids-*.tar.gz
source ./ossec-hids-*/install.sh
echo "Done"
