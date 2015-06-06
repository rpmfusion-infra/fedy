#!/bin/bash

xdg-icon-resource uninstall --novendor --size 128 "clion"

gtk-update-icon-cache -f -t /usr/share/icons/hicolor

rm -f "/usr/bin/clion"
rm -f "/usr/share/applications/clion.desktop"
rm -rf "/opt/clion"
