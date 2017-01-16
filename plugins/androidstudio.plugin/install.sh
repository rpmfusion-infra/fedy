#!/bin/bash

dnf -y install compat-libstdc++-296.i686 compat-libstdc++-33.i686 compat-libstdc++-33.x86_64 glibc.i686 ncurses-libs.i686

CACHEDIR="/var/cache/fedy/androidstudio";

mkdir -p "$CACHEDIR"
cd "$CACHEDIR"

URL=$(wget "http://developer.android.com/sdk/index.html" -O - | grep -o "https://dl.google.com/.*/[0-9.]*/android-studio-ide-[0-9.]*-linux.zip" | head -n 1)
FILE=${URL##*/}

wget -c "$URL" -O "$FILE"

if [[ ! -f "$FILE" ]]; then
	exit 1
fi

rm -rf "/opt/android-studio"
unzip -xq "$FILE" -d "/opt/"

ln -sf "/opt/android-studio/bin/studio.sh" "/usr/bin/android-studio"

xdg-icon-resource install --novendor --size "scalable" "/opt/android-studio/bin/androidstudio.svg" "android-studio"
gtk-update-icon-cache -f -t /usr/share/icons/hicolor

cat <<EOF | tee /usr/share/applications/android-studio.desktop
[Desktop Entry]
Name=Android Studio
Icon=android-studio
Comment=Official IDE for Android application development
Exec=android-studio
Terminal=false
Type=Application
StartupNotify=true
Categories=IDE;Development;
Keywords=Idea;Java;Android;SDK;IDE;
EOF
