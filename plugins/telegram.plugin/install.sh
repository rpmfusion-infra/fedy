#!/bin/bash

CACHEDIR="/var/cache/fedy/telegram";

mkdir -p "$CACHEDIR"
cd "$CACHEDIR"

TELEGRAM_VER=$(wget https://desktop.telegram.org/ -O- | grep -o "v [0-9.]* stable" | head -n 1 | grep -o "[0-9.]*")  
TELEGRAM_FILE_TYPE=.tar.xz

if [[  $(uname -m | grep '64') ]]; then
	TELEGRAM_PATH=https://tdesktop.com/linux/
	TELEGRAM_FILE_START=tsetup.
else
	TELEGRAM_PATH=https://tdesktop.com/linux32/
	TELEGRAM_FILE_START=tsetup32.
fi

TELEGRAM_FILE=$TELEGRAM_FILE_START$TELEGRAM_VER$TELEGRAM_FILE_TYPE
TELEGRAM_URL=$TELEGRAM_PATH$TELEGRAM_FILE

wget $TELEGRAM_URL

if [[ ! -f "$TELEGRAM_FILE" ]]; then
	exit 1
fi

tar -xvJf $TELEGRAM_FILE -C /opt/
rm -rf $TELEGRAM_FILE

ln -sf "/opt/Telegram/Telegram" "/usr/bin/Telegram"

cd /opt/Telegram
wget https://upload.wikimedia.org/wikipedia/commons/thumb/8/82/Telegram_logo.svg/200px-Telegram_logo.svg.png
mv 200px-Telegram_logo.svg.png Telegram.png

xdg-icon-resource install --novendor --size 256 "/opt/Telegram/Telegram.png" "Telegram"
gtk-update-icon-cache -f -t /usr/share/icons/hicolor

cat <<EOF | tee /usr/share/applications/Telegram.desktop
[Desktop Entry]
Name=Telegram
Icon=Telegram
Comment=A new era of messaging
Exec=Telegram
Terminal=false
Type=Application
StartupNotify=true
Categories=Internet;
Keywords=Internet;Messaging;
EOF
