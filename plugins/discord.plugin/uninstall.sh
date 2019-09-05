#!/bin/bash

xdg-icon-resource uninstall --novendor --size "scalable" "discord"

gtk-update-icon-cache -f -t /usr/share/icons/hicolor

rm -f "/usr/bin/discord"
rm -f "/usr/share/applications/discord.desktop"
rm -rf "/opt/Discord"
