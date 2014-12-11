# Name: Install Sublime Text 2
# Command: sublime_text2

sublime_text2() {
show_func "Installing Sublime Text 2"
if [[ "$(sublime_text2_test)" = "Installed" ]]; then
    show_status "Sublime Text 2 already installed"
else
    show_msg "Getting latest version"
    get_file_quiet "http://www.sublimetext.com/2" "sublime2.htm"
    get=$(cat "sublime2.htm" | grep "dl_linux_${arch}" | grep -o "https\?://.*/Sublime.*Text.*.tar.bz2" | head -n 1)
    file=${get##*/}
    get_file

    if [[ -f "$file" ]]; then
        show_msg "Installing files"
        tar -xjf "$file"
        mv "Sublime Text 2" "sublime_text_2"
        cp -af "sublime_text_2" "/opt/"
        for dir in /opt/sublime_text_2/Icon/*; do
            size="${dir##*/}"
            xdg-icon-resource install --novendor --size "${size/x*}" "$dir/sublime_text.png" "sublime_text"
        done
        gtk-update-icon-cache -f -t /usr/share/icons/hicolor > /dev/null 2>&1
        ln -sf "/opt/sublime_text_2/sublime_text" "/usr/bin/subl2"
cat <<EOF | tee /usr/share/applications/sublime-text-2.desktop > /dev/null 2>&1
[Desktop Entry]
Name=Sublime Text 2
GenericName=Text Editor
Icon=sublime_text
Comment=Sophisticated text editor \for code, markup and prose
Exec=subl2 %F
MimeType=text/plain;
Terminal=false
Type=Application
StartupNotify=true
Categories=Development;Utility;TextEditor;
Keywords=Text;Editor;
EOF
    fi
fi
[[ "$(sublime_text2_test)" = "Installed" ]]; exit_state
}

sublime_text2_undo() {
show_func "Uninstalling Sublime Text 2"
if [[ -d /opt/sublime_text_2/Icon ]]; then
    for dir in /opt/sublime_text_2/Icon/*; do
        size="${dir##*/}"
        xdg-icon-resource uninstall --novendor --size "${size/x*}" "$dir/sublime_text.png" "sublime_text"
    done
    gtk-update-icon-cache -f -t /usr/share/icons/hicolor > /dev/null 2>&1
fi
rm -f "/usr/bin/subl2"
rm -f "/usr/share/applications/sublime-text-2.desktop"
rm -rf "/opt/sublime_text_2"
[[ ! "$(sublime_text2_test)" = "Installed" ]]; exit_state
}

sublime_text2_test() {
if [[ -f /opt/sublime_text_2/sublime_text ]]; then
    printf "Installed"
else
    printf "Not installed"
fi
}
