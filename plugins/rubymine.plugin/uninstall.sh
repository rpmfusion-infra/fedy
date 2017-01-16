#!/bin/bash

xdg-icon-resource uninstall --novendor --size 32 "rubymine"

gtk-update-icon-cache -f -t /usr/share/icons/hicolor

rm -f "/usr/bin/rubymine"
rm -f "/usr/share/applications/rubymine.desktop"
rm -rf "/opt/RubyMine"
