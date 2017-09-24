#!/bin/sh

download()
{
    local NOCHECK=
    if [ "$1" = "--no-check-certificate" ] ; then
        NOCHECK="$1"
        shift
    fi
    local filename=$(basename "$1")
    [ -n "$2" ] && filename="$2"
    if [ -s "$filename" ] ; then
        echo "Skipping $1 ..."
        return
    fi
    wget $NOCHECK "$1" -O $filename
}

# http://q.cryptopro.ru/center.htm
#download http://q.cryptopro.ru/qcacer.p7b
#https://e-trust.gosuslugi.ru/Shared/DownloadCert?thumbprint=D24B37FCFBB979D2D4A5D1549EC4E2029D15D8A2
download --no-check-certificate "https://e-trust.gosuslugi.ru/CA/DownloadTSL?schemaVersion=0" TSLExt.1.0.xml
