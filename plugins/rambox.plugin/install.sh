#!/bin/bash

GITHUB_RELEASES_URL="https://api.github.com/repos/saenzramiro/rambox/releases"
GITHUB_DOWNLOAD_URL="https://github.com/saenzramiro/rambox/releases/download"

KERNEL=$(uname -m)

case "$KERNEL" in
  "x86_64") KERNEL_VERSION="x64" ;;
  *) KERNEL_VERSION="ia32" ;;
esac

URL=$(wget "$GITHUB_RELEASES_URL/latest" -O - | grep -o "$GITHUB_DOWNLOAD_URL/[0-9.]*/Rambox-[0-9.]*-$KERNEL_VERSION.rpm" | head -n 1)

dnf -y install $URL
