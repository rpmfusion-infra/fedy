#!/bin/bash

URL=$(wget "https://code-industry.net/free-pdf-editor/" -O - | grep -o "http://.*/master-pdf-editor[0-9a-z.\_-]*.$(uname -m).rpm" | head -n 1)

if [[ "$URL" != "" ]]; then
    dnf -y install "$URL"
else
    exit 1
fi
