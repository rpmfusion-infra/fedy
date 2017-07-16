#!/bin/bash

run-as-root dnf -y remove fedy-font-config

gsettings reset org.gnome.settings-daemon.plugins.xsettings antialiasing
gsettings reset org.gnome.settings-daemon.plugins.xsettings hinting
