# Name: Install TeamViewer
# Command: teamviewer_linux

teamviewer_linux() {
show_func "Installing TeamViewer"
if [[ "$(teamviewer_linux_test)" = "Installed" ]]; then
    show_status "TeamViewer already installed"
else
    get32="http://www.teamviewer.com/download/teamviewer_linux.rpm"
    file32=${get32##*/}
    get64="$get32"
    file64="$file32"
    process_pkg
fi
[[ "$(teamviewer_linux_test)" = "Installed" ]]; exit_state
}

teamviewer_linux_undo() {
show_func "Uninstalling TeamViewer"
erase_pkg teamviewer
[[ ! "$(teamviewer_linux_test)" = "Installed" ]]; exit_state
}

teamviewer_linux_test() {
query_pkg teamviewer
if [[ $? -eq 0 ]]; then
    printf "Installed"
else
    printf "Not installed"
fi
}
