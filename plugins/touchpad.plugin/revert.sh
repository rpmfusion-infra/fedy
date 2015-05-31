#!/bin/bash

gsettings get org.gnome.settings-daemon.peripherals.touchpad tap-to-click > /dev/null 2>&1

if [[ $? -eq 0 ]]; then
    gsettings reset org.gnome.settings-daemon.peripherals.touchpad tap-to-click
else
    gsettings reset org.gnome.desktop.peripherals.touchpad tap-to-click
fi

run-as-root rm -f /etc/X11/xorg.conf.d/00-enable-taps.conf
