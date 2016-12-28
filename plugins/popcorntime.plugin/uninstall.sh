#!/bin/bash

xdg-icon-resource uninstall --novendor --size 256 "popcorn-time"

gtk-update-icon-cache -f -t /usr/share/icons/hicolor

rm -f "/usr/bin/popcorn"
rm -f "/usr/share/applications/popcorn-time.desktop"
rm -rf "/opt/popcorn-time"
