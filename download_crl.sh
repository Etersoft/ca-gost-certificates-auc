#!/bin/sh
epm assure mimetype perl-File-MimeInfo-scripts
rm -f crl.list.tmp
xsltproc tslext-crl.xsl TSLExt.1.0.xml | sort -u >crl.list
rm -rf crl/
mkdir -p crl/

is_crl()
{
    mimetype "$1" | grep -q application/pkix-crl
}

rm -f crl.url.failed.list
cat crl.list | while read name url ; do
    wget --user-agent="Mozilla" --timeout=10 --tries=2 "$url" -O "crl/$name-$(basename "$url")" || rm -fv "crl/$name-$(basename "$url")"
    if ! is_crl "crl/$name-$(basename "$url")" ; then
        rm -fv "crl/$name-$(basename "$url")"
        echo "$name $url" >>crl.url.failed.list
    fi
done

echo "Failed URL list:"
cat crl.url.failed.list
