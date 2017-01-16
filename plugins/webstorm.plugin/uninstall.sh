#!/bin/bash

xdg-icon-resource uninstall --novendor --size 128 "webstorm"

gtk-update-icon-cache -f -t /usr/share/icons/hicolor

rm -f "/usr/bin/webstorm"
rm -f "/usr/share/applications/webstorm.desktop"
rm -rf "/opt/WebStorm"
