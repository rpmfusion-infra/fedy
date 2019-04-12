#!/bin/bash

CACHEDIR="/var/cache/fedy/postman";
mkdir -p "$CACHEDIR"
cd "$CACHEDIR"

if [[ "$(uname -m)" = "x86_64" ]]; then
	ARCH="64"
else
	ARCH="32"
fi

URL="https://dl.pstmn.io/download/latest/linux$ARCH"
FILE=${URL##*/}

wget -c "$URL" -O "$FILE"

if [[ ! -f "$FILE" ]]; then
	exit 1
fi

tar -xzf "$FILE" -C "/opt/"
ln -sf "/opt/Postman/Postman" "/usr/bin/postman"

cp "/opt/Postman/app/resources/app/assets/icon.png" "/usr/share/icons/hicolor/128x128/apps/postman.png"
gtk-update-icon-cache -f -t /usr/share/icons/hicolor

cat <<EOF | tee /usr/share/applications/postman.desktop
[Desktop Entry]
Name=Postman
Type=Application
Exec=postman
Icon=postman
Comment=The most complete toolchain for API developers
Categories=Development;
Keywords=Postman;API;REST;Testing;
StartupNotify=true
Terminal=false
StartupWMClass=postman
EOF
