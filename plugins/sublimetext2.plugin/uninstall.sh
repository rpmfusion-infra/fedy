#!/bin/bash

if [[ -d /opt/sublime_text_2/Icon ]]; then
    for dir in /opt/sublime_text_2/Icon/*; do
        size="${dir##*/}"
        xdg-icon-resource uninstall --novendor --size "${size/x*}" "sublime_text"
    done

    gtk-update-icon-cache -f -t /usr/share/icons/hicolor
fi

rm -rf "/usr/bin/subl2" "/usr/share/applications/sublime-text-2.desktop" "/opt/sublime_text_2"
