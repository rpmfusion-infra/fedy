#!/bin/bash

dnf -y install alsa-lib freetype libXrender libXtst which

CACHEDIR="/var/cache/fedy/androidstudio"
mkdir -p "$CACHEDIR"
cd "$CACHEDIR"

URL=$(curl -s "https://developer.android.com/studio" | grep -oP 'https://dl\.google\.com/dl/android/studio/ide-zips/[^"]+linux\.tar\.gz' | head -n 1)

if [[ -z "$URL" ]]; then
	echo "Error: Could not find Android Studio download URL"
	exit 1
fi

FILE=${URL##*/}

curl -L -C - -o "$FILE" "$URL"

if [[ ! -f "$FILE" ]]; then
	exit 1
fi

rm -rf "/opt/android-studio"
tar xf "$FILE" -C "/opt/"

ln -sf "/opt/android-studio/bin/studio" "/usr/bin/android-studio"

install -Dm644 "/opt/android-studio/bin/studio.png" "/usr/share/pixmaps/android-studio.png"
gtk-update-icon-cache -f -t /usr/share/icons/hicolor

cat <<EOF > /usr/share/applications/android-studio.desktop
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
