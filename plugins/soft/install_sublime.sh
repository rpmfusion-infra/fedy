# Name: Install Sublime Text 3
# Command: install_sublime

install_sublime() {
show_func "Installing Sublime Text 3"
if [[ "$(install_sublime_test)" = "Installed" && ! "$reinstall" = "yes" ]]; then
    show_status "Sublime Text 3 already installed"
else
    show_msg "Fetching webpage"
    get_file_quiet "http://www.sublimetext.com/3" "sublime.htm"
    get=$(cat "sublime.htm" | tr ' ' '\n' | grep -o "http://.*/sublime_text_3_build_[0-9]*_x${arch}.tar.bz2" | head -n 1)
    file=${get##*/}
    get_file
    show_msg "Installing files"
    tar -xjf "$file"
    cp -af "sublime_text_3" "/opt/"
    for dir in /opt/sublime_text_3/Icon/*; do
        size="${dir##*/}"
        xdg-icon-resource install --novendor --size "${size/x*}" "$dir/sublime-text.png" "sublime-text"
    done
    ln -sf "/opt/sublime_text_3/sublime_text" "/usr/bin/subl"
cat <<EOF | tee /usr/share/applications/sublime-text-3.desktop > /dev/null 2>&1
[Desktop Entry]
Name=Sublime Text 3
GenericName=Text Editor
Icon=sublime-text
Comment=Sophisticated text editor \for code, markup and prose
Exec=subl %F
MimeType=text/plain;
Terminal=false
Type=Application
StartupNotify=true
Categories=Development;Utility;TextEditor;
Keywords=Text;Editor;
EOF
fi
[[ "$(install_sublime_test)" = "Installed" ]]; exit_state
}

install_sublime_remove() {
show_func "Removing Sublime Text 3"
for dir in /opt/sublime_text_3/Icon/*; do
    size="${dir##*/}"
    xdg-icon-resource uninstall --novendor --size "${size/x*}" "$dir/sublime-text.png" "sublime-text"
done
rm -f "/usr/bin/subl"
rm -f "/usr/share/applications/sublime-text-3.desktop"
rm -rf "/opt/sublime_text_3"
[[ ! "$(install_sublime_test)" = "Installed" ]]; exit_state
}

install_sublime_test() {
if [[ -f /opt/sublime_text_3/sublime_text ]]; then
    printf "Installed"
else
    printf "Not installed"
fi
}
