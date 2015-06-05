#!/bin/bash

xdg-icon-resource uninstall --novendor --size 256 "intellij-idea"

gtk-update-icon-cache -f -t /usr/share/icons/hicolor

rm -f "/usr/bin/intellij-idea"
rm -f "/usr/share/applications/intellij-idea.desktop"
rm -rf "/opt/intellij-idea"
