#!/bin/bash

GITHUB_RELEASES_URL="https://api.github.com/repos/ramboxapp/community-edition/releases/latest"

KERNEL=$(uname -m)

case "$KERNEL" in
  "x86_64") KERNEL_VERSION="x86_64" ;;
  *) KERNEL_VERSION="ia32" ;;
esac

URL=$(curl -s $GITHUB_RELEASES_URL | grep -i browser_download_url | grep -i $KERNEL_VERSION.rpm | awk '{ print $2; }' | head -n 1 | sed 's/\"//g')

dnf -y install $URL

