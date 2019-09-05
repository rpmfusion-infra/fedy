#!/bin/bash

CACHEDIR="/var/cache/fedy/firefox-developer"
FILE="firefox-developer.tar.bz2"
URL="https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=linux64&lang=en-US"
DIR="/opt/firefox-developer"

[[ -d $CACHEDIR ]] || mkdir -p $CACHEDIR
[[ -f "$CACHEDIR/$FILE" ]] || wget -c "$URL" -O "$CACHEDIR/$FILE"

tar jxf "$CACHEDIR/$FILE" -C "/opt"
mv "/opt/firefox" $DIR

user=$(logname)
[[ -n $user ]] && chown -R $user $DIR
ln -sf "$DIR/firefox" "/usr/bin/firefox-developer"

xdg-icon-resource install --novendor --size 128 "/opt/firefox-developer/browser/chrome/icons/default/default128.png" "firefox-developer"
gtk-update-icon-cache -f -t /usr/share/icons/hicolor

cat > /usr/local/share/applications/firefox-developer.desktop <<EOL
[Desktop Entry]
Version=1.0
Encoding=UTF-8
Name=Firefox Developer Edition
Comment=Firefox Developer Edition
Exec=/usr/bin/firefox-developer
Icon=firefox-developer
Type=Application
StartupNotify=true
Keywords=firefox;dev;browser
Categories=Internet
EOL
