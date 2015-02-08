# Name: Enable DVD playback
# Command: dvd_playback

dvd_playback() {
show_func "Installing libdvdcss"
if [[ "$(dvd_playback_test)" = "Enabled" ]]; then
    show_status "libdvdcss already installed"
else
    add_repo "remi.repo"
    install_pkg libdvdcss
fi
[[ "$(dvd_playback_test)" = "Enabled" ]]; exit_state
}

dvd_playback_undo() {
show_func "Uninstalling libdvdcss"
erase_pkg remi-release libdvdcss
remove_repo "remi.repo"
[[ ! "$(dvd_playback_test)" = "Enabled" ]]; exit_state
}

dvd_playback_test() {
query_pkg libdvdcss
if [[ $? -eq 0 ]]; then
    printf "Enabled"
else
    printf "Not enabled"
fi
}
