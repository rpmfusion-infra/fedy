#!/bin/bash

gsettings get org.gnome.settings-daemon.peripherals.touchpad tap-to-click > /dev/null 2>&1

if [[ $? -eq 0 ]]; then
    gsettings set org.gnome.settings-daemon.peripherals.touchpad tap-to-click true
else
    gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
fi

cat <<EOF | run-as-root tee /etc/X11/xorg.conf.d/00-enable-taps.conf > /dev/null 2>&1
Section "InputClass"
       Identifier "tap-by-default"
       MatchIsTouchpad "on"
       Option "TapButton1" "1"
EndSection
EOF
