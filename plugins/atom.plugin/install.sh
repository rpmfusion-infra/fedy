#!/bin/bash

# Switching to cache directory

CACHEDIR="/var/cache/fedy/atom-editor";

mkdir -p "$CACHEDIR"
cd "$CACHEDIR"

# Finding latest release and downloading them.
# As of now atom only has x86_64 package for .rpm

URL=$(curl -Ls -o /dev/null -w %{url_effective} https://github.com/atom/atom/releases/latest)
wget https://github.com/atom/atom/releases/download/${URL##*/}/atom.x86_64.rpm

dnf -y install ./atom.x86_64.rpm zenity

# Install plugin for updating on linux which
# Disabling it by default for performance (One can enable it when required)
# Installing plugin notifing about update (PS. Better to change setting on this)
# All this because Atom does not automatically update on linux.

apm install atom-updater-linux
apm disable atom-updater-linux
apm install updater-notify
