#!/bin/bash

dnf -y install java-*-openjdk-devel

if [[ "$(uname -m)" = "x86_64" ]]; then
	ARCH="64"
else
	ARCH="32"
fi

CACHEDIR="/var/cache/fedy/arduino";
mkdir -p "$CACHEDIR"
cd "$CACHEDIR"
VERSION=$(wget "https://www.arduino.cc/en/Main/ReleaseNotes" -O - | grep -Po "ARDUINO [0-9.]{5}" | head -n 1 | cut -c 9-)
FILE=arduino-$VERSION-linux$ARCH.tar.xz
URL=https://downloads.arduino.cc/$FILE

wget -c "$URL" -O "$FILE"

if [[ ! -f "$FILE" ]]; then
	exit 1
fi

tar -xf "$FILE" -C "/opt/"
mv "/opt/${FILE:0:13}" "/opt/arduino"

ln -sf "/opt/arduino/arduino-$VERSION/arduino" "/usr/bin/arduino"
/opt/arduino/arduino-$VERSION/install.sh

cp "/opt/arduino/arduino-$VERSION/arduino.desktop" "/usr/local/share/applications"

rm -f "$HOME/.local/share/applications/arduino.desktop"
rm -f "$HOME/Desktop/arduino.desktop"
