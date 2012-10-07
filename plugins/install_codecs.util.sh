# Name: Install multimedia codecs
# Command: install_codecs
# Value: True

install_codecs() {
show_func "Installing multimedia codecs"
if [[ "$(install_codecs_test)" = "Installed" ]]; then
	show_status "GStreamer plugins already installed"
else
	add_repo "rpmfusion-free.repo" "rpmfusion-nonfree.repo"
	install_pkg gstreamer-ffmpeg gstreamer-plugins-good gstreamer-plugins-bad gstreamer-plugins-bad-free gstreamer-plugins-bad-nonfree gstreamer-plugins-ugly faac faad2 libdca libmad libmatroska xvidcore
fi
# Remove possible defective thumbnails
rm -rf "$homedir/.thumbnails/*"
[[ "$(install_codecs_test)" = "Installed" ]]; exit_state
}

install_codecs_test() {
if [[ -d /usr/lib/gstreamer-0.10 ]]; then
	printf "Installed"
else
	printf "Not installed"
fi
}
