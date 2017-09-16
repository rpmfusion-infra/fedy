#!/bin/bash

URL=$(curl -sL "http://code-industry.net/free-pdf-editor.php" | grep -o "http://.*/master-pdf-editor.*.$(uname -m).rpm" |head -n 1 |cut -d\" -f1)

if [[ "$URL" != "" ]]; then
    dnf -y install "$URL"
else
    exit 1
fi
