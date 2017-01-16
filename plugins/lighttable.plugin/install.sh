#!/bin/bash

CACHEDIR="/var/cache/fedy/lighttable"
DESTDIR="/opt/LightTable"

if [[ "$(uname -m)" = "x86_64" ]]; then
	ARCH="64"
else
	ARCH=""
fi

mkdir -p "$CACHEDIR"
cd "$CACHEDIR"

URL=$(wget "http://lighttable.com" -O - | grep -o "https://github.com/LightTable/LightTable/releases/download/[0-9.]*/lighttable-[0-9.]*-linux.tar.gz" | head -n 1)
FILE=${URL##*/}

wget -c "$URL" -O "$FILE"

if [[ ! -f "$FILE" ]]; then
	exit 1
fi

mkdir -p "$DESTDIR" && tar -xf "$FILE" -C "$DESTDIR" --strip 1
ln -sf "$DESTDIR/LightTable" "/usr/bin/LightTable"

xdg-icon-resource install --novendor --size 256 "/opt/LightTable/resources/app/core/img/lticon.png" "lticon"

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
