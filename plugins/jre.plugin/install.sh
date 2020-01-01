#!/bin/bash

CACHEDIR="/var/cache/fedy/jre"

if [[ "$(uname -m)" = "x86_64" ]]; then
    ARCH="x64"
else
    ARCH="x86"
fi

mkdir -p "$CACHEDIR"
cd "$CACHEDIR"

URL=$(wget $(wget "http://www.oracle.com/technetwork/java/javase/downloads/index.html" -O - | tr ' ' '\n' | grep "/technetwork/java/javase/downloads/jre8" | head -n 1 | cut -d\" -f 2 | sed -e 's/^/http:\/\/www.oracle.com/') -O - | grep "Linux ${ARCH}" | grep ".rpm" | cut -d\" -f 12 | grep -v demos | head -n 1)
FILE=${URL##*/}

wget --header "Cookie: oraclelicense=a" -c "$URL" -O "$FILE"

if [[ -f "$FILE" ]]; then
    rpm -Uvh "$FILE"
else
    exit 1
fi

alternatives --install /usr/bin/java java /usr/java/latest/bin/java 2000000
alternatives --auto java

if [[ "$arch" = "x86" ]]; then
    alternatives --install /usr/lib/mozilla/plugins/libjavaplugin.so libjavaplugin.so /usr/java/latest/lib/i386/libnpjp2.so 2000000
    alternatives --auto libjavaplugin.so
elif [[ "$arch" = "x64" ]]; then
    alternatives --install /usr/lib64/mozilla/plugins/libjavaplugin.so libjavaplugin.so.x86_64 /usr/java/latest/lib/amd64/libnpjp2.so 2000000
    alternatives --auto libjavaplugin.so.x86_64
fi
