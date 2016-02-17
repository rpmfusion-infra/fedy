#!/bin/bash

URL=$(wget "http://code-industry.net/free-pdf-editor.php" -O - | grep -o "http://.*/master-pdf-editor[0-9a-z.\-]*.$(uname -m).rpm" | head -n 1)

if [[ "$URL" != "" ]]; then
    dnf -y install "$URL"
else
    exit 1
fi
