#!/bin/bash

#dnf -y install 

CACHEDIR="/var/cache/fedy/discord";

mkdir -p "$CACHEDIR"
cd "$CACHEDIR"

URL="https://discordapp.com/api/download?platform=linux&format=tar.gz"
FILE="discord.tar.gz"

wget -c "$URL" -O "$FILE"

if [[ ! -f "$FILE" ]]; then
	exit 1
fi

rm -rf "/opt/Discord/"
tar -xzf "$FILE" -C "/opt/"

ln -sf "/opt/Discord/Discord" "/usr/bin/discord"
chmod +x "/opt/Discord/Discord"

xdg-icon-resource install --novendor --size 128 "/opt/Discord/discord.png" "discord"
gtk-update-icon-cache -f -t /usr/share/icons/hicolor

cat <<EOF | tee /usr/share/applications/discord.desktop
[Desktop Entry]
Name=Discord
StartupWMClass=discord
Comment=All-in-one voice and text chat for gamers that's free, secure, and works on both your desktop and phone.
GenericName=Internet Messenger
Exec=discord
Icon=discord
Type=Application
Categories=Network;InstantMessaging;
EOF
