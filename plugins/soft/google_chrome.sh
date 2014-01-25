# Name: Install Google Chrome
# Command: google_chrome

google_chrome() {
show_func "Installing Google Chrome"
if [[ "$(google_chrome_test)" = "Installed" && ! "$reinstall" = "yes" ]]; then
    show_status "Google Chrome already installed"
else
    get32="https://dl.google.com/linux/direct/google-chrome-stable_current_i386.rpm"
    file32=${get32##*/}
    get64="https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm"
    file64=${get64##*/}
    process_pkg
fi
[[ "$(google_chrome_test)" = "Installed" ]]; exit_state
}

google_chrome_undo() {
show_func "Uninstalling Google Chrome"
erase_pkg google-chrome-stable
[[ ! "$(google_chrome_test)" = "Installed" ]]; exit_state
}

google_chrome_test() {
query_pkg google-chrome-stable
if [[ $? -eq 0 ]]; then
    printf "Installed"
else
    printf "Not installed"
fi
}
