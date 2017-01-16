#!/bin/bash

CACHEDIR="/var/cache/fedy/sublimetext2"

if [[ "$(uname -m)" = "x86_64" ]]; then
	ARCH="x64"
else
	ARCH="x32"
fi

mkdir -p "$CACHEDIR"
cd "$CACHEDIR"

URL="http://c758482.r82.cf2.rackcdn.com/Sublime Text 2.0.2 ${ARCH}.tar.bz2"
FILE=${URL##*/}

wget -c "$URL" -O "$FILE"

if [[ ! -f "$FILE" ]]; then
	exit 1
fi

tar -xjf "$FILE"

if [[ ! -d "Sublime Text 2" ]]; then
	exit 1
fi

mv "Sublime Text 2" "sublime_text_2"
rm -rf "/opt/sublime_text_2/"
cp -af "$CACHEDIR/sublime_text_2" "/opt/"

for dir in /opt/sublime_text_2/Icon/*; do
    size="${dir##*/}"
    xdg-icon-resource install --novendor --size "${size/x*}" "$dir/sublime_text.png" "sublime-text-2"
done

gtk-update-icon-cache -f -t /usr/share/icons/hicolor

ln -sf "/opt/sublime_text_2/sublime_text" "/usr/bin/subl2"

cat <<EOF | tee /usr/share/applications/sublime-text-2.desktop
[Desktop Entry]
Name=Sublime Text 2
GenericName=Text Editor
Icon=sublime-text-2
Comment=Sophisticated text editor \for code, markup and prose
Exec=subl2 %F
MimeType=text/plain;
Terminal=false
Type=Application
StartupNotify=true
Categories=Development;Utility;TextEditor;
Keywords=Text;Editor;
EOF
