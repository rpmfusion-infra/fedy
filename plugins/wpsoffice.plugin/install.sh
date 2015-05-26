#!/bin/bash

URL=$(wget "http://wps-community.org/download.html" -O - | tr ' ' '\n' | grep -o "https\?://.*/wps-office-.*$(uname -m).rpm" | head -n 1)

if [[ "$URL" != "" ]]; then
	dnf -y install "$URL"
else
	exit 1
fi
