#!/bin/bash

if [[ -d /opt/sublime_text_3/Icon ]]; then
    for dir in /opt/sublime_text_3/Icon/*; do
        size="${dir##*/}"
        xdg-icon-resource uninstall --novendor --size "${size/x*}" "sublime-text"
    done

    gtk-update-icon-cache -f -t /usr/share/icons/hicolor
fi

rm -rf "/usr/bin/subl" "/usr/share/applications/sublime-text-3.desktop" "/opt/sublime_text_3"
