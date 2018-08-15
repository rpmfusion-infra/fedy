#!/bin/bash

CACHEDIR="/var/cache/fedy/zoom";

mkdir -p "$CACHEDIR"
cd "$CACHEDIR"

wget https://zoom.us/client/latest/zoom_$(uname -m).rpm -O zoom.rpm

dnf -y install ./zoom.rpm
