# Name: Install multimedia codecs
# Command: install_codecs

codeclist=( "amrnb" "amrwb" "faac" "faad2" "flac" "gstreamer1-libav" "gstreamer1-plugins-bad-free" "gstreamer1-plugins-bad-freeworld" "gstreamer1-plugins-base" "gstreamer1-plugins-fc" "gstreamer1-plugins-good" "gstreamer1-plugins-ugly" "gstreamer-ffmpeg" "gstreamer-plugins-bad" "gstreamer-plugins-bad-free" "gstreamer-plugins-bad-nonfree" "gstreamer-plugins-base" "gstreamer-plugins-entrans" "gstreamer-plugins-espeak" "gstreamer-plugins-fc" "gstreamer-plugins-good" "gstreamer-plugins-ugly" "gstreamer-rtsp" "lame" "libdca" "libmad" "libmatroska" "x264" "xvidcore" )

install_codecs() {
show_func "Installing multimedia codecs"
if [[ "$(install_codecs_test)" = "Installed" && ! "$reinstall" = "yes" ]]; then
	show_status "Multimedia codecs already installed"
else
	add_repo "rpmfusion-free.repo" "rpmfusion-nonfree.repo"
	install_pkg ${codeclist[@]}
fi
# Remove possible defective thumbnails
rm -rf "$homedir/.thumbnails/*"
[[ "$(install_codecs_test)" = "Installed" ]]; exit_state
}

install_codecs_test() {
for codec in ${codeclist[@]}; do
	ls /usr/share/doc/$codec-* > /dev/null 2>&1
	if [[ ! $? -eq 0 ]]; then
		codecinstalled="no"
		break
	fi
done
if [[ ! "$codecinstalled" = "no" ]]; then
	printf "Installed"
else
	printf "Not installed"
fi
}
