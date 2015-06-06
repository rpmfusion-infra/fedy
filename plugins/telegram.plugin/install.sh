#!/bin/bash

CACHEDIR="/var/cache/fedy/telegram";

mkdir -p "$CACHEDIR"
cd "$CACHEDIR"

TELEGRAM_VER=$(wget https://desktop.telegram.org/ -O- | grep -o "v [0-9.]* stable" | head -n 1 | grep -o "[0-9.]*")
TELEGRAM_FILE_TYPE=".tar.xz"

if [[ "$(uname -m)" = "x86_64" ]]; then
	TELEGRAM_PATH="https://tdesktop.com/linux/"
	TELEGRAM_FILE_BASE="tsetup."
else
	TELEGRAM_PATH="https://tdesktop.com/linux32/"
	TELEGRAM_FILE_BASE="tsetup32."
fi

TELEGRAM_FILE="${TELEGRAM_FILE_BASE}${TELEGRAM_VER}${TELEGRAM_FILE_TYPE}"
TELEGRAM_URL="${TELEGRAM_PATH}${TELEGRAM_FILE}"

wget -c "$TELEGRAM_URL" -O "$TELEGRAM_FILE"

if [[ ! -f "$TELEGRAM_FILE" ]]; then
	exit 1
fi

tar -xvJf "$TELEGRAM_FILE" -C "/opt/"

ln -sf "/opt/Telegram/Telegram" "/usr/bin/telegram"

wget "https://web.telegram.org/img/logo_share.png" -O "/opt/Telegram/logo_share.png"

xdg-icon-resource install --novendor --size 256 "/opt/Telegram/logo_share.png" "telegram"
gtk-update-icon-cache -f -t /usr/share/icons/hicolor

cat <<EOF | tee /usr/share/applications/telegram.desktop
[Desktop Entry]
Name=Telegram
Icon=telegram
Comment=A new era of messaging
Exec=telegram
Terminal=false
Type=Application
StartupNotify=true
Categories=Internet;
Keywords=Internet;Messaging;
EOF
