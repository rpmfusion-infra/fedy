#!/bin/bash

dnf -y install curl cabextract xorg-x11-font-utils fontconfig

CACHEDIR="/var/cache/fedy/mscorefonts";
mkdir -p "$CACHEDIR"
cd "$CACHEDIR"

URL=$(wget http://mscorefonts2.sourceforge.net/ -O - | grep -Po https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-[0-9.]{3}-[0-9].noarch.rpm)
FILE=${URL##*/}

wget -c "$URL" -O "$FILE"

if [[ ! -f "$FILE" ]]; then
	exit 1
fi

dnf -y install "$FILE"
