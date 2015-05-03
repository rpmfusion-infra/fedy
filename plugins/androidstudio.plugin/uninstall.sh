#!/bin/bash

xdg-icon-resource uninstall --novendor --size "scalable" "android-studio"

gtk-update-icon-cache -f -t /usr/share/icons/hicolor

rm -f "/usr/bin/android-studio"
rm -f "/usr/share/applications/android-studio.desktop"
rm -rf "/opt/android-studio"
