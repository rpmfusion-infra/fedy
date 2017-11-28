#!/bin/bash

rm "/usr/share/icons/hicolor/128x128/apps/postman.png"
gtk-update-icon-cache -f -t /usr/share/icons/hicolor

rm -f "/usr/bin/postman"
rm -f "/usr/share/applications/postman.desktop"
rm -rf "/opt/Postman"
