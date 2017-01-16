#!/bin/bash

dnf -y install java-1.8.0-openjdk java-1.8.0-openjdk-devel

PACKAGE="dsl"

CACHEDIR="/var/cache/fedy/eclipse-$PACKAGE"
INSTALLDIR="/opt/eclipse-$PACKAGE"

mkdir -p "$CACHEDIR"
cd "$CACHEDIR"

BASEURL="http://mirror.cc.vt.edu/pub/eclipse/technology/epp/downloads/release"
PRESENTRELEASE=$(wget $BASEURL/release.xml -O - | grep present | sed -n 's:.*<present>\(.*\)</present>.*:\1:p')
PRODUCT=$(wget --quiet $BASEURL/$PRESENTRELEASE/$PACKAGE.xml -O - | grep "<product name=" | sed 's/.*"\(.*\)"[^"]*$/\1/')

if [[ $(uname -m) == 'x86_64' ]]; then
	URL=$BASEURL/$PRESENTRELEASE/$PRODUCT-linux-gtk-x86_64.tar.gz
else
	URL=$BASEURL/$PRESENTRELEASE/$PRODUCT-linux-gtk.tar.gz
fi

FILE=${URL##*/}

wget -c "$URL" -O "$FILE"

if [[ ! -f "$FILE" ]]; then
	exit 1
fi

rm -rf $INSTALLDIR
mkdir -p $INSTALLDIR
tar -zxf "$FILE" -C $INSTALLDIR --strip-components=1

ln -sf "$INSTALLDIR/eclipse" "/usr/bin/eclipse-$PACKAGE"

xdg-icon-resource install --novendor --size 256 "$INSTALLDIR/icon.xpm" "eclipse"
gtk-update-icon-cache -f -t /usr/share/icons/hicolor

cat <<EOF | tee /usr/share/applications/eclipse-$PACKAGE.desktop
[Desktop Entry]
Encoding=UTF-8
Name=Eclipse DSL
Comment=Eclipse IDE for Java and DSL Developers
Exec=eclipse-$PACKAGE
Icon=eclipse
Terminal=false
Type=Application
Categories=GNOME;Application;Development;IDE;
StartupNotify=true
StartupWMClass=Eclipse
EOF
