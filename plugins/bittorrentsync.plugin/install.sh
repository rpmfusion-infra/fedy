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

if [[ ! -f "$FILE" ]]; then
	exit 1
fi

mkdir -p /opt/btsync
tar -xzf "$FILE" -C "/opt/btsync"

ln -sf "/opt/btsync/btsync" "/usr/bin/btsync"
