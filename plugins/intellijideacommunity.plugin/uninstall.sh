#!/bin/bash

xdg-icon-resource uninstall --novendor --size 128 "intellij-idea-ce"

gtk-update-icon-cache -f -t /usr/share/icons/hicolor

rm -f "/usr/bin/ideaIC"
rm -f "/usr/share/applications/intellij-idea-community.desktop"
rm -rf "/opt/intellij-idea-community"
