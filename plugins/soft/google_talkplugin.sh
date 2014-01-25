# Name: Install Google Talk plugin
# Command: google_talkplugin

google_talkplugin() {
show_func "Installing Google Talk plugin"
if [[ "$(google_talkplugin_test)" = "Installed" ]]; then
    show_status "Google Talk plugin already installed"
else
    get32="http://dl.google.com/linux/direct/google-talkplugin_current_i386.rpm"
    file32=${get32##*/}
    get64="http://dl.google.com/linux/direct/google-talkplugin_current_x86_64.rpm"
    file64=${get64##*/}
    process_pkg
fi
[[ "$(google_talkplugin_test)" = "Installed" ]]; exit_state
}

google_talkplugin_undo() {
show_func "Uninstalling Google Talk plugin"
erase_pkg google-talkplugin
[[ ! "$(google_talkplugin_test)" = "Installed" ]]; exit_state
}

google_talkplugin_test() {
query_pkg google-talkplugin
if [[ $? -eq 0 ]]; then
    printf "Installed"
else
    printf "Not installed"
fi
}
