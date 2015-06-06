#!/bin/bash

dnf -y install java-1.8.0-openjdk java-1.8.0-openjdk-devel

CACHEDIR="/var/cache/fedy/intellij-idea";
mkdir -p "$CACHEDIR"
cd "$CACHEDIR"

URL=$(wget "https://www.jetbrains.com/idea/download/download_thanks.jsp?os=linux&edition=IC" -O - | grep -o "https://download.jetbrains.com/idea/ideaIC-[0-9.]*.tar.gz" | head -n 1)
FILE=${URL##*/}

wget -c "$URL" -O "$FILE"

if [[ ! -f "$FILE" ]]; then
	exit 1
fi

rm -rf "/opt/intellij-idea-community"
tar -xzf "$FILE" -C "/opt"

mv /opt/idea-IC* /opt/intellij-idea-community
ln -sf "/opt/intellij-idea-community/bin/idea.sh" "/usr/bin/ideaIC"

xdg-icon-resource install --novendor --size 128 "/opt/intellij-idea-community/bin/idea.png" "intellij-idea-ce"
gtk-update-icon-cache -f -t /usr/share/icons/hicolor

cat <<EOF | tee /usr/share/applications/intellij-idea-community.desktop
[Desktop Entry]
Name=IntelliJ IDEA Community Edition
Type=Application
Icon=intellij-idea-ce
Exec=ideaIC
Comment=The Most Intelligent Java IDE
Categories=Development;IDE;
Keywords=Idea;Java;IDE;
StartupNotify=true
Terminal=false
StartupWMClass=jetbrains-idea
EOF
