#!/bin/bash

rpm --import https://dl-ssl.google.com/linux/linux_signing_key.pub
dnf -y install https://dl.google.com/linux/direct/google-chrome-stable_current_$(uname -i).rpm


# Fix for double icon in dock
file="/usr/share/applications/google-chrome.desktop"
str_arr=("Desktop Entry" "NewWindow Shortcut Group" "NewIncognito Shortcut Group")
fix_str="StartupWMClass=Google-chrome-stable"

for i in "${str_arr[@]}"
do
    line=`grep -n "\\[$i\\]" $file | cut -d : -f 1`
    ((line++))
    sed -i "$line"'i\'"$fix_str" $file
done
