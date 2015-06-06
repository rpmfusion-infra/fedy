#!/bin/bash

dnf -y install java-1.8.0-openjdk java-1.8.0-openjdk-devel

CACHEDIR="/var/cache/fedy/intellij-idea";
mkdir -p "$CACHEDIR"
cd "$CACHEDIR"

URL=$(wget "https://www.jetbrains.com/idea/download/download_thanks.jsp?os=linux&edition=IU" -O - | grep -o "https://download.jetbrains.com/idea/ideaIU-[0-9.]*.tar.gz" | head -n 1)
FILE=${URL##*/}

wget -c "$URL" -O "$FILE"

if [[ ! -f "$FILE" ]]; then
	exit 1
fi

rm -rf "/opt/intellij-idea-ultimate"
tar -xzf "$FILE" -C "/opt"

mv /opt/idea-IU* /opt/intellij-idea-ultimate
ln -sf "/opt/intellij-idea-ultimate/bin/idea.sh" "/usr/bin/ideaIU"

xdg-icon-resource install --novendor --size 128 "/opt/intellij-idea-ultimate/bin/idea.png" "intellij-idea-ultimate-edition"
gtk-update-icon-cache -f -t /usr/share/icons/hicolor

cat <<EOF | tee /usr/share/applications/intellij-idea-ultimate.desktop
[Desktop Entry]
Name=IntelliJ IDEA Ultimate Edition
Type=Application
Icon=intellij-idea-ultimate-edition
Exec=ideaIU
Comment=The Most Intelligent Java IDE
Categories=Development;IDE;
Keywords=Idea;Java;IDE;
StartupNotify=true
Terminal=false
StartupWMClass=jetbrains-idea
EOF
