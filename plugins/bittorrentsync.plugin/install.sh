#!/bin/bash

if [[ "$(uname -m)" = "x86_64" ]]; then
	ARCH="x64"
else
	ARCH="i386"
fi

CACHEDIR="/var/cache/fedy/resilio-syn";
mkdir -p "$CACHEDIR"
cd "$CACHEDIR"

URL=https://download-cdn.resilio.com/stable/linux-$ARCH/resilio-sync_$ARCH.tar.gz
FILE=${URL##*/}

wget -c "$URL" -O "$FILE"

if [[ ! -f "$FILE" ]]; then
	exit 1
fi

mkdir -p /opt/rslsync
tar -xzf "$FILE" -C "/opt/rslsync"

ln -sf "/opt/rslsync/rslsync" "/usr/bin/rslsync"
