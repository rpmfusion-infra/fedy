#!/bin/bash

CACHEDIR="/var/cache/fedy/skype"

mkdir -p "$CACHEDIR"
cd "$CACHEDIR"

URL="https://go.skype.com/skypeforlinux-64.rpm"
FILE="skype_linux.rpm"

wget -c "$URL" -O "$FILE"

if [[ ! -f "$FILE" ]]; then
	exit 1
fi

dnf -y install gtk2-engines.i686
dnf -y install $FILE
