#!/bin/bash

rm "/usr/share/icons/hicolor/scalable/apps/gitkraken.svg"
gtk-update-icon-cache -f -t /usr/share/icons/hicolor

rm -f "/usr/bin/gitkraken"
rm -f "/usr/share/applications/gitkraken.desktop"
rm -rf "/opt/gitkraken"
