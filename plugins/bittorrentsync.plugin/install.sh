#!/bin/bash

if [[ "$(uname -m)" = "x86_64" ]]; then
	ARCH="x64"
else
	ARCH="i386"
fi

CACHEDIR="/var/cache/fedy/bittorrent-syn";
mkdir -p "$CACHEDIR"
cd "$CACHEDIR"

URL=https://download-cdn.getsync.com/stable/linux-$ARCH/BitTorrent-Sync_$ARCH.tar.gz
FILE=${URL##*/}

wget -c "$URL" -O "$FILE"

echo "use \"sudo btsync\" to start"
