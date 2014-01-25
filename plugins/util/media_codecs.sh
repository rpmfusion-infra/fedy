# Name: Install multimedia codecs
# Command: media_codecs

codeclistbase=( "amrnb" "amrwb" "faac" "faad2" "flac" "gstreamer1-libav" "gstreamer1-plugins-bad-freeworld" "gstreamer1-plugins-ugly" "gstreamer-ffmpeg" "gstreamer-plugins-bad-nonfree" "gstreamer-plugins-espeak" "gstreamer-plugins-fc" "gstreamer-plugins-ugly" "gstreamer-rtsp" "lame" "libdca" "libmad" "libmatroska" "x264" "xvidcore" )

codeclistall=( ${codeclistbase[@]} "gstreamer1-plugins-bad-free" "gstreamer1-plugins-base" "gstreamer1-plugins-good" "gstreamer-plugins-bad" "gstreamer-plugins-bad-free" "gstreamer-plugins-base" "gstreamer-plugins-good" )

media_codecs() {
show_func "Installing multimedia codecs"
if [[ "$(media_codecs_test)" = "Installed" ]]; then
    show_status "Multimedia codecs already installed"
else
    add_repo "rpmfusion-free.repo" "rpmfusion-nonfree.repo"
    install_pkg ${codeclistall[@]}
fi
# Remove possible defective thumbnails
rm -rf "$homedir/.thumbnails/" "$homedir/.cache/thumbnails/"
[[ "$(media_codecs_test)" = "Installed" ]]; exit_state
}

media_codecs_undo() {
show_func "Uninstalling multimedia codecs"
erase_pkg ${codeclistbase[@]}
[[ ! "$(media_codecs_test)" = "Installed" ]]; exit_state
}

media_codecs_test() {
query_pkg ${codeclistall[@]}
if [[ $? -eq 0 ]]; then
    printf "Installed"
else
    printf "Not installed"
fi
}
