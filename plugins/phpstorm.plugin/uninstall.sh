#!/bin/bash

xdg-icon-resource uninstall --novendor --size 256 "phpstorm"

gtk-update-icon-cache -f -t /usr/share/icons/hicolor

rm -f "/usr/bin/phpstorm"
rm -f "/usr/share/applications/phpstorm.desktop"
rm -rf "/opt/PhpStorm"
