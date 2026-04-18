#!/bin/bash

rm -f "/usr/share/pixmaps/android-studio.png"
gtk-update-icon-cache -f -t /usr/share/icons/hicolor

rm -f "/usr/bin/android-studio"
rm -f "/usr/share/applications/android-studio.desktop"
rm -rf "/opt/android-studio"
rm -rf "/var/cache/fedy/androidstudio"
