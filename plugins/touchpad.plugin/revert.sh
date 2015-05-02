#!/bin/bash

run-as-root rm -f /etc/X11/xorg.conf.d/00-enable-taps.conf
gsettings reset org.gnome.settings-daemon.peripherals.touchpad tap-to-click
