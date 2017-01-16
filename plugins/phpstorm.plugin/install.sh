#!/bin/bash

dnf -y install java-1.8.0-openjdk java-1.8.0-openjdk-devel compat-libstdc++-296.i686 compat-libstdc++-33.i686 compat-libstdc++-33.x86_64 glibc.i686 ncurses-libs.i686

CACHEDIR="/var/cache/fedy/phpstorm";
mkdir -p "$CACHEDIR"
cd "$CACHEDIR"

URL=$(wget "https://data.services.jetbrains.com/products/releases?code=PS&latest=true" -O -| grep -o "https://download.jetbrains.com/webide/PhpStorm-[0-9.]*.tar.gz" | head -n 1)
FILE=${URL##*/}

wget -c "$URL" -O "$FILE"

if [[ ! -f "$FILE" ]]; then
	exit 1
fi

tar -xzf "$FILE" -C "/opt/"

mv /opt/PhpStorm* "/opt/PhpStorm"
ln -sf "/opt/PhpStorm/bin/phpstorm.sh" "/usr/bin/phpstorm"

xdg-icon-resource install --novendor --size 256 "/opt/PhpStorm/bin/webide.png" "phpstorm"
gtk-update-icon-cache -f -t /usr/share/icons/hicolor

cat <<EOF | tee /usr/share/applications/phpstorm.desktop
[Desktop Entry]
Name=PhpStorm
Type=Application
Icon=phpstorm
Exec=phpstorm
Comment=The Most Intelligent PHP IDE
Categories=Development;IDE;
Keywords=Idea;PHP;Web;Jetbrains;IDE;
StartupNotify=true
Terminal=false
StartupWMClass=jetbrains-phpstorm
EOF
