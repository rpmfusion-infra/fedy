#!/bin/bash

xdg-icon-resource uninstall --novendor --size 256 "lticon"

gtk-update-icon-cache -f -t /usr/share/icons/hicolor

rm -f "/usr/bin/LightTable"
rm -f "/usr/share/applications/lighttable.desktop"
rm -rf "/opt/LightTable"
