#!/bin/sh

epm assure mimetype perl-File-MimeInfo-scripts

is_crl()
{
    [ -s "$1" ] || return
    mimetype "$1" | grep -q application/pkix-crl
}


rm -f crl.url.failed.list.tmp
cat crl.url.failed.list | while read name url ; do
    rm -f "crl/$name-$(basename "$url")"
    wget --user-agent="Mozilla" --timeout=10 --tries=2 "$url" -O "crl/$name-$(basename "$url")" || rm -fv "crl/$name-$(basename "$url")"
    if ! is_crl "crl/$name-$(basename "$url")" ; then
        rm -fv "crl/$name-$(basename "$url")"
        echo "$name $url" >>crl.url.failed.list.tmp
    fi
done

echo "Changes in failed URL list:"
diff -u crl.url.failed.list crl.url.failed.list.tmp
mv -f crl.url.failed.list.tmp crl.url.failed.list
