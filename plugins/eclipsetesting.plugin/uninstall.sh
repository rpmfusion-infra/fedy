#!/bin/bash

PACKAGE="testing"

xdg-icon-resource uninstall --novendor --size 256 "eclipse"
gtk-update-icon-cache -f -t /usr/share/icons/hicolor

rm -f "/usr/bin/eclipse-$PACKAGE"
rm -f "/usr/share/applications/eclipse-$PACKAGE.desktop"
rm -rf "/opt/eclipse-$PACKAGE"
