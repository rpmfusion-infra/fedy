#!/bin/bash

dnf -y install java-1.8.0-openjdk java-1.8.0-openjdk-devel compat-libstdc++-296.i686 compat-libstdc++-33.i686 compat-libstdc++-33.x86_64 glibc.i686 ncurses-libs.i686

CACHEDIR="/var/cache/fedy/pycharm-professional";
mkdir -p "$CACHEDIR"
cd "$CACHEDIR"

URL=$(wget "https://data.services.jetbrains.com/products/releases?code=PCP&latest=true" -O - | grep -o "https://download.jetbrains.com/python/pycharm-professional-[0-9.]*.tar.gz" | head -n 1)
FILE=${URL##*/}

wget -c "$URL" -O "$FILE"

if [[ ! -f "$FILE" ]]; then
	exit 1
fi

tar -xzf "$FILE" -C "/opt/"

mv /opt/pycharm* "/opt/pycharm-professional"
ln -sf "/opt/pycharm-professional/bin/pycharm.sh" "/usr/bin/pycharm-professional"

xdg-icon-resource install --novendor --size 128 "/opt/pycharm-professional/bin/pycharm.png" "pycharm"
gtk-update-icon-cache -f -t /usr/share/icons/hicolor

cat <<EOF | tee /usr/share/applications/pycharm-professional.desktop
[Desktop Entry]
Name=PyCharm Professional
Icon=pycharm
Comment=Python IDE & Django IDE for Web Developers
Exec=pycharm-professional
Terminal=false
Type=Application
StartupNotify=true
Categories=IDE;Development;
Keywords=Jetbrains;python;Django;IDE;
EOF
