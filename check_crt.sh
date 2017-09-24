#!/bin/sh -x
if echo "$1" | grep -q "\.crl" ; then
    CMD=crl
else
    CMD=x509
fi

openssl $CMD -inform der -nameopt utf8 -text -noout -in "$1"
