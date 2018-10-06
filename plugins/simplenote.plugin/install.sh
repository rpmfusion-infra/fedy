#!/bin/bash

CACHEDIR="/var/cache/fedy/simplenote";
mkdir -p "$CACHEDIR"
cd "$CACHEDIR"

API_URI="https://api.github.com"

URL=$(curl \
    -H "Accept: application/vnd.github.v3+json" \
    "${API_URI}/repos/automattic/simplenote-electron/releases/latest" |\
    jq -r --arg ARCH "$(uname -m).rpm" '.assets[] | select(.name | contains($ARCH)) | .browser_download_url')

if [[ -z "$URL" ]]; then
  echo "Failed to find download URL"
  exit 1
fi

dnf install -y libappindicator
dnf install -y "$URL"