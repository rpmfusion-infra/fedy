#!/bin/bash

run-as-root dnf -y install ozon-font-config

gsettings set org.gnome.settings-daemon.plugins.xsettings antialiasing "rgba"
gsettings set org.gnome.settings-daemon.plugins.xsettings hinting "slight"
