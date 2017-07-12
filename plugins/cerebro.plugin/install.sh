#!/bin/bash

#Switching to cache directory

CACHEDIR="/var/cache/fedy/cerebro";

mkdir -p "$CACHEDIR"
cd "$CACHEDIR"

URL=$(curl -Ls -o /dev/null -w %{url_effective} https://github.com/KELiON/cerebro/releases/latest)

DLF=https://github.com/KELiON/cerebro/releases/download/${URL##*/}/cerebro-$( echo ${URL##*/} | cut -c 2-)-x86_64.AppImage

wget -c $DLF -O cerebro.AppImage

chmod +x cerebro.AppImage
mv cerebro.AppImage /opt/cerebro.AppImage

# first run needed to integrate in system.
