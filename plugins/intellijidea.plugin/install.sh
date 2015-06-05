#!/bin/bash

dnf -y install compat-libstdc++-296.i686 compat-libstdc++-33.i686 compat-libstdc++-33.x86_64 glibc.i686 ncurses-libs.i686

CACHEDIR="/var/cache/fedy/intellij-idea-community";

mkdir -p "$CACHEDIR"
cd "$CACHEDIR"

IDEA_PATH=https://download.jetbrains.com/idea/
IDEA_FILE_START=ideaIC-
IDEA_FILE_TYPE=tar.gz
IDEA_VER=$(wget http://www.jetbrains.com/idea/download/download_thanks.jsp -O- | grep -o "idea..-[0-9.]*" | head -n 1 | grep -o "[0-9.]*")

IDEA_FILE=$IDEA_FILE_START$IDEA_VER$IDEA_FILE_TYPE
IDEA_URL=$IDEA_PATH$IDEA_FILE

wget $IDEA_URL

if [[ ! -f "$IDEA_FILE" ]]; then
	exit 1
fi

rm -rf "/opt/intellij-idea"
tar -zxvf $IDEA_FILE -C /opt/
rm -rf $IDEA_FILE
mv /opt/idea-IC* /opt/intellij-idea

ln -sf "/opt/intellij-idea/bin/idea.sh" "/usr/bin/intellij-idea"

xdg-icon-resource install --novendor --size 256 "/opt/intellij-idea/bin/idea.png" "intellij-idea"
gtk-update-icon-cache -f -t /usr/share/icons/hicolor

cat <<EOF | tee /usr/share/applications/intellij-idea.desktop
[Desktop Entry]
Name=IntelliJ-Idea
Icon=intellij-idea
Comment=The Most Intelligent Java IDE
Exec=intellij-idea
Terminal=false
Type=Application
StartupNotify=true
Categories=IDE;Development;
Keywords=Idea;Java;IDE;
EOF
