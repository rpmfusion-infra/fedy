# Name: Install GTalk plugin
# Command: install_gtalk

install_gtalk() {
show_func "Installing GTalk plugin"
if [[ "$(install_gtalk_test)" = "Installed" && ! "$reinstall" = "yes" ]]; then
    show_status "GTalk plugin already installed"
else
    get32="http://dl.google.com/linux/direct/google-talkplugin_current_i386.rpm"
    file32=${get32##*/}
    get64="http://dl.google.com/linux/direct/google-talkplugin_current_x86_64.rpm"
    file64=${get64##*/}
    process_pkg
fi
[[ "$(install_gtalk_test)" = "Installed" ]]; exit_state
}

install_gtalk_remove() {
show_func "Removing GTalk plugin"
erase_pkg google-talkplugin
[[ ! "$(install_gtalk_test)" = "Installed" ]]; exit_state
}

install_gtalk_test() {
if [[ -f /opt/google/talkplugin/GoogleTalkPlugin ]]; then
    printf "Installed"
else
    printf "Not installed"
fi
}
