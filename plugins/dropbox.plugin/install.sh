#!/bin/bash

if [[ "$(uname -m)" = "x86_64" ]]; then
	ARCH="64"
else
	ARCH="32"
fi

URL=$(wget "https://www.dropbox.com/install?os=lnx" -O - | tr ' ' '\n' | grep -o "nautilus-dropbox-[0-9]*.[0-9]*.[0-9]*-[0-9]*.fedora.$(uname -i).rpm" | head -n 1 | sed -e 's/^/http:\/\/linux.dropbox.com\/packages\/fedora\//')

if [[ "$URL" != "" ]]; then
	dnf -y install "$URL"
else
	exit 1
fi
