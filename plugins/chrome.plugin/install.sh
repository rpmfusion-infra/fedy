#!/bin/bash

rpm --import https://dl-ssl.google.com/linux/linux_signing_key.pub
dnf -y install https://dl.google.com/linux/direct/google-chrome-stable_current_$(uname -i).rpm


# Fix for double icon in dock
file="/usr/share/applications/google-chrome.desktop"
if [ -f ${file} ]; then
    list=("Desktop Entry" "new-window" "new-private-window")
    startupWMClass="StartupWMClass=Google-chrome-stable"

    echo
    for i in "${list[@]}"; do
        pattern='^\[.*'"$i"'.*\]$'
        section=$(grep "$pattern" $file)
        lineNumber=$(grep -n "$pattern" $file | cut -d : -f 1)

        if [[ $lineNumber ]]; then
            echo "OK: Section [$i] found."
            sed --in-place "$lineNumber a $startupWMClass" $file
        else
            echo "ERROR: Section [$i] not found."
            exit 1
        fi
    done
else
    echo "Desktop file not found."
    exit 1
fi
