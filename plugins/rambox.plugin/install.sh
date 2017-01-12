#!/bin/bash

CACHEDIR="/var/cache/fedy/rambox";
INSTALLDIR="/opt/rambox"
CURRENTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
GITHUB_RELEASES_URL="https://api.github.com/repos/saenzramiro/rambox/releases"
GITHUB_DOWNLOAD_URL="https://github.com/saenzramiro/rambox/releases/download"

mkdir -p "$CACHEDIR"
cd "$CACHEDIR"

KERNEL=$(uname -m)

case "$KERNEL" in
  "x86_64") KERNEL_VERSION="x64" ;;
  *) KERNEL_VERSION="ia32" ;;
esac

URL=$(wget "$GITHUB_RELEASES_URL/latest" -O - | grep -o "$GITHUB_DOWNLOAD_URL/[0-9.]*/rambox-[0-9.]*-$KERNEL_VERSION.tar.gz" | head -n 1)
FILE=${URL##*/}

echo $URL
echo $FILE

wget -c "$URL" -O "$FILE"

if [[ ! -f "$FILE" ]]; then
	exit 1
fi

tar -xzf "$FILE" -C "/opt/"

mv /opt/rambox* "$INSTALLDIR"
ln -sf "/opt/rambox/Rambox" "/usr/bin/rambox"

xdg-icon-resource install --novendor --size 128 "$CURRENTDIR/128x128.png" "rambox"
gtk-update-icon-cache -f -t /usr/share/icons/hicolor

cat <<EOF | tee /usr/share/applications/rambox.desktop
[Desktop Entry]
Name=Rambox
Icon=rambox
Comment=Free and Open Source messaging and emailing app
Exec=rambox
Terminal=false
Type=Application
StartupNotify=true
Categories=Messaging;
Keywords=Slack;Messenger;WhatsApp;Skype;WeChat;Telegram;Hangouts;HipChat;ChatWork;Discord;Steam;GroupeMe;Gitter;Grape
EOF
