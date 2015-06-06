#!/bin/bash

xdg-icon-resource uninstall --novendor --size 128 "intellij-idea-ue"

gtk-update-icon-cache -f -t /usr/share/icons/hicolor

rm -f "/usr/bin/ideaIU"
rm -f "/usr/share/applications/intellij-idea-ultimate.desktop"
rm -rf "/opt/intellij-idea-ultimate"
