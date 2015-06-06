#!/bin/bash

xdg-icon-resource uninstall --novendor --size 256 "telegram"

gtk-update-icon-cache -f -t /usr/share/icons/hicolor

rm -f "/usr/bin/telegram"
rm -f "/usr/share/applications/telegram.desktop"
rm -rf "/opt/Telegram"
