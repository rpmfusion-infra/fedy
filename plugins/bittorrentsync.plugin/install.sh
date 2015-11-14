#!/bin/bash

if [[ "$(uname -m)" = "x86_64" ]]; then
	ARCH="x64"
else
	ARCH="i386"
fi

CACHEDIR="/var/cache/fedy/bittorrent-syn";
mkdir -p "$CACHEDIR"
cd "$CACHEDIR"

wget -P /var/tmp/ https://download-cdn.getsync.com/stable/linux-$ARCH/BitTorrent-Sync_$ARCH.tar.gz

mkdir -pv /opt/btsync
tar xzfv /var/tmp/BitTorrent-Sync_$ARCH.tar.gz -C /opt/btsync

ln -sf /opt/btsync/btsync /usr/local/bin/btsync

echo "use \"sudo btsync\" to start"
