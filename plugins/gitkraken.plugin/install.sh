#!/bin/bash

dnf -y install libXScrnSaver

CACHEDIR="/var/cache/fedy/gitkraken";
mkdir -p "$CACHEDIR"
cd "$CACHEDIR"

URL="https://release.gitkraken.com/linux/gitkraken-amd64.tar.gz"
FILE=${URL##*/}

wget -c "$URL" -O "$FILE"

if [[ ! -f "$FILE" ]]; then
	exit 1
fi

tar -xzf "$FILE" -C "/opt/"

ln -sf "/opt/gitkraken/gitkraken" "/usr/bin/gitkraken"

cp "$(dirname $0)/gitkraken.svg" "/usr/share/icons/hicolor/scalable/apps/"
gtk-update-icon-cache -f -t /usr/share/icons/hicolor

cat << EOF | tee /usr/share/applications/gitkraken.desktop
[Desktop Entry]
Name=GitKraken
Type=Application
Icon=gitkraken
Exec=gitkraken
Comment=The downright luxurious Git client
Categories=Development;IDE;
Keywords=Git;
StartupNotify=true
Terminal=false
EOF
