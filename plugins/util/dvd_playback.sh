# Name: Enable DVD playback
# Command: dvd_playback

dvd_playback() {
show_func "Installing DVD codecs"
if [[ "$(dvd_playback_test)" = "Enabled" && ! "$reinstall" = "yes" ]]; then
    show_status "DVD codecs already installed"
else
    add_repo "rpmfusion-free.repo" "rpmfusion-nonfree.repo"
    install_pkg libdvdread libdvdnav lsdvd
    show_func "Installing libdvdcss2"
    add_repo "livna.repo"
    install_pkg --enablerepo=livna libdvdcss
fi
[[ "$(dvd_playback_test)" = "Enabled" ]]; exit_state
}

dvd_playback_undo() {
show_func "Uninstalling DVD codecs"
erase_pkg libdvdcss libdvdread libdvdnav livna-release lsdvd
remove_repo "livna.repo"
[[ ! "$(dvd_playback_test)" = "Enabled" ]]; exit_state
}

dvd_playback_test() {
ls /usr/lib*/libdvdread.so.4 > /dev/null 2>&1 && ls /usr/lib*/libdvdnav.so.4 > /dev/null 2>&1 && ls /usr/bin/lsdvd > /dev/null 2>&1 && ls /usr/lib*/libdvdcss.so.2 > /dev/null 2>&1
if [[ $? -eq 0 ]]; then
    printf "Enabled"
else
    printf "Not enabled"
fi
}
