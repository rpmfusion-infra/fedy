#!/bin/bash

rm "/usr/share/icons/hicolor/scalable/apps/jetbrains-toolbox.svg"
gtk-update-icon-cache -f -t /usr/share/icons/hicolor

rm -f "/usr/bin/jetbrains-toolbox"
rm -f "/usr/share/applications/jetbrains-toolbox.desktop"
rm -rf "/opt/jetbrains-toolbox"
