#!/bin/sh
rm -rf auc/
mkdir -p auc/
rm -rf auc-pem/
mkdir -p auc-pem/

fatal()
{
    echo "ERROR" >&2
    exit 1
}

print_cert()
{
    local name="$1"
    local file="$2"

    if echo "$file" | grep -q "\.crl" ; then
        CMD=crl
    else
        CMD=x509
    fi

    printf '#\n# %s\n#\n\n' "$name"
    openssl $CMD -inform der -sha256 -nameopt utf8 -in $file -text -fingerprint || return 1
    printf '\n\n'
}

echo "Extract certs from xml..."
rm -f ca-gost-intermediate-bundle.crt
xsltproc tslext.xsl TSLExt.1.0.xml | while read name data ; do
    echo "$data" | base64 -d > auc/$name.crt
    print_cert $name auc/$name.crt >auc-pem/$name.pem || fatal
    cat auc-pem/$name.pem >>ca-gost-intermediate-bundle.crt || fatal
done

c_rehash auc-pem/

echo "Convert CRL from .crt to .pem"
rm -rf crl-pem/
mkdir -p crl-pem/
ls -1 crl/ | while read file ; do
    name=$(basename $file .crl)
    print_cert $name crl/$file >crl-pem/$name.pem
done

c_rehash crl-pem/
