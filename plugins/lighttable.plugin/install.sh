#!/bin/bash

CACHEDIR="/var/cache/fedy/lighttable"

if [[ "$(uname -m)" = "x86_64" ]]; then
	ARCH="64"
else
	ARCH=""
fi

mkdir -p "$CACHEDIR"
cd "$CACHEDIR"

URL=$(wget "http://lighttable.com" -O - | grep -o "https://[a-z0-9]*.cloudfront.net/playground/bins/[0-9.]*/LightTableLinux${ARCH}.tar.gz" | head -n 1)
FILE=${URL##*/}

wget -c "$URL" -O "$FILE"

if [[ ! -f "$FILE" ]]; then
	exit 1
fi

tar -xf "$FILE" -C "/opt"
ln -sf "/opt/LightTable/LightTable" "/usr/bin/LightTable"

cat <<EOF | tee /usr/share/applications/lighttable.desktop
[Desktop Entry]
Name=LightTable
Icon=lighttable
Comment=The Next Generation Code Editor
Exec=LightTable
Terminal=false
Type=Application
StartupNotify=true
Categories=TextEditor;IDE
Keywords=Editor;IDE;Development
EOF
