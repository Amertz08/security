#!/usr/bin/env bash

# Downloads OSSECS
# Tested:
#   Ubuntu 16.04


# Downloads OSSEC
download() {
    echo "Downloading OSSEC"
    mkdir /opt/ossec
    wget -U ossec https://bintray.com/artifact/download/ossec/ossec-hids/ossec-hids-2.8.3.tar.gz
    wget -U ossec https://raw.githubusercontent.com/ossec/ossec-docs/master/docs/whatsnew/checksums/2.8.3/ossec-hids-2.8.3.tar.gz.sha256

}

# Verifies download and deletes if not valid
verify() {
    # Verify proper download
    check=$(sha256sum -c  ossec-hids-2.8.3.tar.gz.sha256 ossec-hids-2.8.3.tar.gz | grep "OK")
    if [[ $check != *"OK"* ]]; then
        echo "sha256 check failed!"
        rm ossec-hids-*.tar.gz
        kill -INT $$
    else
        echo "Download verified!"
    fi
}

# Extracts and cleans up
extract() {
    tar -zxvf ossec-hids-*.tar.gz -C /opt/ossec --strip-components=1
    rm ossec-hids-*.tar.gz ossec-hids-*.tar.gz.sha256
}

# Moves configuration file
mvconf() {
    if [ -f ./etc/ossec.conf ]; then
        mv ./etc/ossec.conf /var/ossec/etc/ossec.conf
    else
        echo ""
        echo "ATTN:  ossec.conf not found"
        echo ""
    fi
}

# Runs install
# TODO: skip install wizard?
install() {
    /opt/ossec/install.sh
}

# Runs the whole shebang
main() {
    download
    verify
    extract
    install
}

main
