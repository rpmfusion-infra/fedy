# Name: Install Sublime Text 3
# Command: install_sublime

install_sublime() {
show_func "Installing Sublime Text 3"
if [[ "$(install_sublime_test)" = "Installed" && ! "$reinstall" = "yes" ]]; then
    show_status "Sublime Text 3 already installed"
else
    show_msg "Fetching webpage"
    get_file_quiet "http://www.sublimetext.com/3" "sublime.htm"
    if [[ "$arch" = "32" ]]; then
        get=$(cat "sublime.htm" | tr ' ' '\n' | grep -o "http://.*/sublime_text_3_build_[0-9]*_x32.tar.bz2")
    elif [[ "$arch" = "64" ]]; then
        get=$(cat "sublime.htm" | tr ' ' '\n' | grep -o "http://.*/sublime_text_3_build_[0-9]*_x64.tar.bz2")
    fi
    file=${get##*/}
    get_file
    tar -xvjf "$file"
    cp -rf "sublime_text_3" "/opt/"
    ln -sf "/opt/sublime_text_3/sublime_text" "/usr/bin/subl"
    ln -sf "/opt/sublime_text_3/Icon/256x256/sublime-text.png" "/usr/share/icons/hicolor/256x256/apps/sublime-text.png"
show_msg "Creating desktop file"
cat <<EOF | tee /usr/share/applications/sublime-text-3.desktop > /dev/null 2>&1
[Desktop Entry]
Name=Sublime Text 3
GenericName=Text Editor
Icon=sublime-text
Comment=Sophisticated text editor
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

install_sublime_test() {
if [[ -f /opt/sublime_text_3/sublime_text ]]; then
    printf "Installed"
else
    printf "Not installed"
fi
}
