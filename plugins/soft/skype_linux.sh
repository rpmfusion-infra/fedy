# Name: Install Skype
# Command: skype_linux

skype_linux() {
show_func "Installing Skype"
if [[ "$(skype_linux_test)" = "Installed" && ! "$reinstall" = "yes" ]]; then
    show_status "Skype already installed"
else
    add_repo "skype.repo"
    show_msg "Installing dependencies"
    install_pkg alsa-lib.i686 libXv.i686 libXScrnSaver.i686 qt.i686 qt-x11.i686 pulseaudio-libs.i686 pulseaudio-libs-glib2.i686 alsa-plugins-pulseaudio.i686 qtwebkit.i686
    get32="http://download.skype.com/linux/skype-4.2.0.11-fedora.i586.rpm"
    file32=${get32##*/}
    get64="$get32"
    file64="$file32"
    process_pkg
fi
[[ "$(skype_linux_test)" = "Installed" ]]; exit_state
}

skype_linux_undo() {
show_func "Uninstalling Skype"
erase_pkg skype
remove_repo "skype.repo"
[[ ! "$(skype_linux_test)" = "Installed" ]]; exit_state
}

skype_linux_test() {
query_pkg skype
if [[ $? -eq 0 ]]; then
    printf "Installed"
else
    printf "Not installed"
fi
}
