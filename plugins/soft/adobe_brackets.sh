# Name: Install Brackets
# Command: adobe_brackets

adobe_brackets() {
show_func "Installing Brackets"
if [[ "$(adobe_brackets_test)" = "Installed" ]]; then
    show_status "Brackets already installed"
else
    show_msg "Installing dependencies"
    install_pkg atk ca-certificates cairo cups dbus expat fontconfig freetype gcc GConf2 gdk-pixbuf2 glib2 gtk2 libcurl libgcrypt libstdc++ libX11 libXcomposite libXdamage libXext libXfixes libXrandr libXrender nspr nss pango redhat-lsb wget xdg-utils
    show_msg "Getting latest version"
    get_file_quiet "http://download.brackets.io/" "brackets.htm"
    get=$(cat "brackets.htm" | tr ' ' '\n' | grep -o "file.cfm?platform=LINUX${arch}&build=[0-9]*" | head -n 1 | sed -e 's/^/http:\/\/download.brackets.io\//')
    file="brackets-LINUX.deb"
    get_file
    show_msg "Installing files"
    mkdir -p "${file%.*}"
    ar p "$file" "data.tar.gz" | tar -C "${file%.*}" -xzf -
    cp -af ${file%.*}/* "/"
    for icon in /opt/brackets/appshell*.png; do
        size="${icon##*/appshell}"
        xdg-icon-resource install --novendor --size "${size%.png}" "$icon" "brackets"
    done
    gtk-update-icon-cache -f -t /usr/share/icons/hicolor > /dev/null 2>&1
    xdg-desktop-menu install --novendor /opt/brackets/brackets.desktop
    if [[ "$arch" = "32" ]]; then
        libdir="/usr/lib"
    elif [[ "$arch" = "64" ]]; then
        libdir="/usr/lib64"
    fi
    nss_files="libnspr4.so.0d libplds4.so.0d libplc4.so.0d libssl3.so.1d libnss3.so.1d libsmime3.so.1d libnssutil3.so.1d"
    for f in $nss_files; do
        target=$(echo $f | sed 's/\.[01]d$//')
        if [[ -f "$libdir/$target" ]]; then
            ln -snf "$libdir/$target" "/opt/brackets/$f"
        else
            show_err "$f not found in $libdir/$target"
        fi
    done
    [[ -f $libdir/libudev.so.1 ]] && ln -snf $libdir/libudev.so.1 $libdir/libudev.so.0
fi
[[ "$(adobe_brackets_test)" = "Installed" ]]; exit_state
}

adobe_brackets_undo() {
show_func "Uninstalling Brackets"
if [[ -d /opt/brackets ]]; then
    for icon in /opt/brackets/appshell*.png; do
        size="${icon##*/appshell}"
        xdg-icon-resource uninstall --novendor --size "${size%.png}" "$icon" "brackets"
    done
fi
gtk-update-icon-cache -f -t /usr/share/icons/hicolor > /dev/null 2>&1
xdg-desktop-menu uninstall --novendor "/opt/brackets/brackets.desktop"
if [[ "$arch" = "32" ]]; then
    libdir="/usr/lib"
elif [[ "$arch" = "64" ]]; then
    libdir="/usr/lib64"
fi
rm -f "$libdir/libudev.so.0"
rm -rf "/opt/brackets/"
[[ ! "$(adobe_brackets_test)" = "Installed" ]]; exit_state
}

adobe_brackets_test() {
if [[ -f /opt/brackets/brackets ]]; then
    printf "Installed"
else
    printf "Not installed"
fi
}
