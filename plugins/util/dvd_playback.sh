# Name: Enable DVD playback
# Command: dvd_playback

dvdlist=( "libdvdread" "libdvdnav" "lsdvd" )

dvd_playback() {
show_func "Installing DVD codecs"
if [[ "$(dvd_playback_test)" = "Enabled" ]]; then
    show_status "DVD codecs already installed"
else
    add_repo "rpmfusion-free.repo" "rpmfusion-nonfree.repo"
    install_pkg ${dvdlist[@]}
    show_func "Installing libdvdcss2"
    add_repo "livna.repo"
    install_pkg --enablerepo=livna libdvdcss
fi
[[ "$(dvd_playback_test)" = "Enabled" ]]; exit_state
}

dvd_playback_undo() {
show_func "Uninstalling DVD codecs"
erase_pkg ${dvdlist[@]}
erase_pkg livna-release
remove_repo "livna.repo"
[[ ! "$(dvd_playback_test)" = "Enabled" ]]; exit_state
}

dvd_playback_test() {
query_pkg ${dvdlist[@]}
if [[ $? -eq 0 ]]; then
    printf "Enabled"
else
    printf "Not enabled"
fi
}
