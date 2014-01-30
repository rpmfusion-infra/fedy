# Name: Install Light Table
# Command: light_table

light_table() {
show_func "Installing Light Table"
if [[ "$(light_table_test)" = "Installed" ]]; then
    show_status "Light Table already installed"
else
    show_msg "Getting latest version"
    get_file_quiet "http://www.lighttable.com/" "lighttable.htm"
    if [[ "$arch" = "32" ]]; then
        get=$(cat "lighttable.htm" | tr ' ' '\n' | grep -o "https\?://.*/LightTableLinux.tar.gz")
    elif [[ "$arch" = "64" ]]; then
        get=$(cat "lighttable.htm" | tr ' ' '\n' | grep -o "https\?://.*/LightTableLinux64.tar.gz")
    fi
    file=${get##*/}
    echo $file
    get_file
    show_msg "Installing files"
    tar -xzf "$file"
    cp -af "LightTable" "/opt/"
    cp -f "/opt/LightTable/core/img/lticon.png" "/usr/share/icons/hicolor/256x256/apps/lticon.png"
    ln -sf "/opt/LightTable/LightTable" "/usr/bin/LightTable"
    if [[ "$arch" = "32" ]]; then
        libdir="/usr/lib"
    elif [[ "$arch" = "64" ]]; then
        libdir="/usr/lib64"
    fi
    [[ -f $libdir/libudev.so.1 ]] && ln -snf $libdir/libudev.so.1 $libdir/libudev.so.0
    gtk-update-icon-cache -f -t /usr/share/icons/hicolor
cat <<EOF | tee /usr/share/applications/LightTable.desktop > /dev/null 2>&1
[Desktop Entry]
Name=Light Table
GenericName=Interactive IDE
Icon=lticon
Comment=Interactive IDE with real time feedback 
Exec=LightTable %F
Terminal=false
Type=Application
StartupNotify=true
Categories=Development;Utility;TextEditor;
Keywords=Development;Editor;IDE;Text;
EOF
fi
[[ "$(light_table_test)" = "Installed" ]]; exit_state
}

light_table_undo() {
show_func "Uninstalling Light Table"
if [[ "$arch" = "32" ]]; then
    libdir="/usr/lib"
elif [[ "$arch" = "64" ]]; then
    libdir="/usr/lib64"
fi
rm -f "$libdir/libudev.so.0"
rm -f "/usr/bin/LightTable"
rm -f "/usr/share/applications/LightTable.desktop"
rm -f "/usr/share/icons/hicolor/256x256/apps/lticon.png"
rm -rf "/opt/LightTable/"
gtk-update-icon-cache -f -t /usr/share/icons/hicolor
[[ ! "$(light_table_test)" = "Installed" ]]; exit_state
}

light_table_test() {
if [[ -f /opt/LightTable/LightTable ]]; then
    printf "Installed"
else
    printf "Not installed"
fi
}
