# Name: Install multimedia codecs
# Command: install_codecs
# Value: True

install_codecs() {
show_func "Installing multimedia codecs"
if [[ "$(install_codecs_test)" = "Installed" ]]; then
	show_status "GStreamer plugins already installed"
else
	add_repo "rpmfusion-free.repo" "rpmfusion-nonfree.repo"
	install_pkg faac faad2 gstreamer1 gstreamer-plugins-bad gstreamer-plugins-bad-free gstreamer-plugins-bad-nonfree gstreamer-plugins-base gstreamer-plugins-entrans gstreamer-plugins-espeak gstreamer-plugins-fc gstreamer-plugins-good gstreamer-plugins-good-extras gstreamer-plugins-tools gstreamer-plugins-ugly libdca libmad libmatroska xvidcore
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
