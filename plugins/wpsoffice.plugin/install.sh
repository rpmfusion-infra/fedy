#!/bin/bash

URL=$(wget "http://wps-community.org/download.html" -O - | tr ' ' '\n' | grep -o "https\?://.*/wps-office-.*$(uname -m).rpm\"" | head -n 1 | rev | cut -c 2- | rev )
 
if [[ "$URL" != "" ]]; then
	dnf -y install "$URL"
else
	exit 1
fi
