#!/bin/bash

xdg-icon-resource uninstall --novendor --size 128 "pycharm"

gtk-update-icon-cache -f -t /usr/share/icons/hicolor

rm -f "/usr/bin/pycharm-professional"
rm -f "/usr/share/applications/pycharm-professional.desktop"
rm -rf "/opt/pycharm-professional"
