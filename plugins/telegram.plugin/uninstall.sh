#!/bin/bash

xdg-icon-resource uninstall --novendor --size 256 "Telegram"

gtk-update-icon-cache -f -t /usr/share/icons/hicolor

rm -f "/usr/bin/Telegram"
rm -f "/usr/share/applications/Telegram.desktop"
rm -rf "/opt/Telegram"
