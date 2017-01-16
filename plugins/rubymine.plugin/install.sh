#!/bin/bash

dnf -y install java-1.8.0-openjdk java-1.8.0-openjdk-devel compat-libstdc++-296.i686 compat-libstdc++-33.i686 compat-libstdc++-33.x86_64 glibc.i686 ncurses-libs.i686

CACHEDIR="/var/cache/fedy/rubymine";
mkdir -p "$CACHEDIR"
cd "$CACHEDIR"

URL=$(wget "https://data.services.jetbrains.com/products/releases?code=RM&latest=true" -O - | grep -o "https://download.jetbrains.com/ruby/RubyMine-[0-9.]*.tar.gz" | head -n 1)
FILE=${URL##*/}

wget -c "$URL" -O "$FILE"

if [[ ! -f "$FILE" ]]; then
	exit 1
fi

tar -xzf "$FILE" -C "/opt/"

mv /opt/RubyMine* "/opt/RubyMine"
ln -sf "/opt/RubyMine/bin/rubymine.sh" "/usr/bin/rubymine"

xdg-icon-resource install --novendor --size 32 "/opt/RubyMine/bin/rubymine.png" "rubymine"
gtk-update-icon-cache -f -t /usr/share/icons/hicolor

cat <<EOF | tee /usr/share/applications/rubymine.desktop
[Desktop Entry]
Name=RubyMine
Type=Application
Icon=rubymine
Exec=rubymine
Comment=The Most Intelligent Ruby and Rails IDE
Categories=Development;IDE;
Keywords=Idea;Ruby;Rails;Jetbrains;IDE;
StartupNotify=true
Terminal=false
StartupWMClass=jetbrains-idea
EOF
