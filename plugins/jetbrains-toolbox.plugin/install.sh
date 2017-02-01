#!/bin/bash

dnf -y install java-1.8.0-openjdk java-1.8.0-openjdk-devel compat-libstdc++-296.i686 compat-libstdc++-33.i686 compat-libstdc++-33.x86_64 glibc.i686 ncurses-libs.i686

CACHEDIR="/var/cache/fedy/jetbrains-toolbox";
mkdir -p "$CACHEDIR"
cd "$CACHEDIR"

URL=$(wget "https://data.services.jetbrains.com/products/releases?code=TBA&latest=true&type=release" -O -| grep -o "https://download.jetbrains.com/toolbox/jetbrains-toolbox-[0-9.]*.tar.gz" | head -n 1)
FILE=${URL##*/}

wget -c "$URL" -O "$FILE"

if [[ ! -f "$FILE" ]]; then
	exit 1
fi

tar -xzf "$FILE" -C "/opt/"

mv /opt/jetbrains-toolbox* "/opt/jetbrains-toolbox"
ln -sf "/opt/jetbrains-toolbox/jetbrains-toolbox" "/usr/bin/jetbrains-toolbox"

cp "$(dirname $0)/jetbrains-toolbox.svg" "/usr/share/icons/hicolor/scalable/apps/"
gtk-update-icon-cache -f -t /usr/share/icons/hicolor

cat <<EOF | tee /usr/share/applications/jetbrains-toolbox.desktop
[Desktop Entry]
Name=JetBrains Toolbox App
Type=Application
Exec=jetbrains-toolbox
Icon=jetbrains-toolbox
Comment=A control panel for your tools and projects
Categories=Development;IDE;
Keywords=Idea;PHPStorm;Web;Toolbox;Jetbrains;IDE;
StartupNotify=true
Terminal=false
StartupWMClass=jetbrains-toolbox
EOF
