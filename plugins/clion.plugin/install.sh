#!/bin/bash

dnf -y install java-1.8.0-openjdk java-1.8.0-openjdk-devel compat-libstdc++-296.i686 compat-libstdc++-33.i686 compat-libstdc++-33.x86_64 glibc.i686 ncurses-libs.i686

CACHEDIR="/var/cache/fedy/clion";
mkdir -p "$CACHEDIR"
cd "$CACHEDIR"

URL=$(wget "https://data.services.jetbrains.com/products/releases?code=CL&latest=true" -O - | grep -o "https://download.jetbrains.com/cpp/CLion-[0-9.]*.tar.gz" | head -n 1)
FILE=${URL##*/}

wget -c "$URL" -O "$FILE"
[[ -f "$FILE" ]] || exit 1

mkdir "/opt/clion/"
tar -xzf "$FILE" -C "/opt/clion" --strip-components=1
ln -sf "/opt/clion/bin/clion.sh" "/usr/bin/clion"

xdg-icon-resource install --novendor --size 128 "/opt/clion/bin/clion.svg" "clion"
gtk-update-icon-cache -f -t /usr/share/icons/hicolor

cat <<EOF | tee /usr/share/applications/clion.desktop
[Desktop Entry]
Name=CLion
Icon=clion
Comment=This powerful IDE helps you develop in C and C++ on Linux
Exec=clion
Terminal=false
Type=Application
StartupNotify=true
Categories=IDE;Development;
Keywords=Jetbrains;C;C++;IDE;
EOF
