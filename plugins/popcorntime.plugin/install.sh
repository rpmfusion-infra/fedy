#!/bin/bash

CACHEDIR="/var/cache/fedy/popcorntime"

if [[ "$(uname -m)" = "x86_64" ]]; then
  ARCH="64"
else
  ARCH="32"
fi

mkdir -p "$CACHEDIR"
cd "$CACHEDIR"

# https://get.popcorntime.sh/build/Popcorn-Time-0.3.10-Linux-64.tar.xz
URL=$(wget "https://popcorntime.sh/en" -O - | grep -o "https://get.popcorntime.sh/build/\S*${ARCH}.tar.xz" | head -n 1)
FILE=${URL##*/}

wget -c "$URL" -O "$FILE"

if [[ ! -f "$FILE" ]]; then
  exit 1
fi

mkdir -p "/opt/popcorn-time"
tar -xf "$FILE" -C "/opt/popcorn-time"
unzip "/opt/popcorn-time/package.nw" "src/app/images/icon.png" -d "/opt/popcorn-time"
ln -sf "/opt/popcorn-time/Popcorn-Time" "/usr/bin/popcorn"
dnf -y install libXScrnSaver

xdg-icon-resource install --novendor --size 256 "/opt/popcorn-time/src/app/images/icon.png" "popcorn-time"
gtk-update-icon-cache -f -t /usr/share/icons/hicolor

cat <<EOF | tee /usr/share/applications/popcorn-time.desktop
[Desktop Entry]
Name=Popcorn Time
Icon=popcorn-time
Comment=A whole new way to watch movies and TV
Exec=popcorn
Terminal=false
Type=Application
StartupNotify=true
Categories=Video;BitTorrent
Keywords=Popcorn;Video;torrent;stream
EOF
