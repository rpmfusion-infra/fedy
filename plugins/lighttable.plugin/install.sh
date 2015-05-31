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

xdg-icon-resource install --novendor --size 256 "/opt/LightTable/core/img/lticon.png" "lticon"

gtk-update-icon-cache -f -t /usr/share/icons/hicolor

# Workaround for https://github.com/LightTable/LightTable/issues/1894
if [[ "$ARCH" = "64" ]]; then
    libdir="/usr/lib64"
else
    libdir="/usr/lib"
fi

[[ -f "/opt/LightTable/libudev.so.0" ]] || ln -snf "$libdir/libudev.so.1" "/opt/LightTable/libudev.so.0"

cat <<EOF | tee /usr/share/applications/lighttable.desktop
[Desktop Entry]
Name=Light Table
GenericName=Interactive IDE
Icon=lticon
Comment=The Next Generation Code Editor
Exec=LightTable %F
Terminal=false
Type=Application
StartupNotify=true
Categories=Development;Utility;TextEditor;
Keywords=Development;Editor;IDE;Text;
EOF
