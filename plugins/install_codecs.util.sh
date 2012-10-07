# Name: Install multimedia codecs
# Command: install_codecs
# Value: True

install_codecs() {
show_func "Installing multimedia codecs"
if [[ "$(install_codecs_test)" = "Installed" || "$(install_codecs_test)" = "Partial" ]]; then
	show_status "GStreamer plugins already installed"
else
	add_repo "rpmfusion-free.repo" "rpmfusion-nonfree.repo"
	install_pkg gstreamer-plugins-good gstreamer-plugins-bad gstreamer-plugins-bad-free gstreamer-plugins-bad-nonfree gstreamer-plugins-ugly faac faad2 libdca libmad libmatroska xvidcore
fi
# Install MPlayer Codecs if Architecture is 32-bit
if [[ "$arch" = "32" ]]; then
	show_func "Installing MPlayer codecs"
	if [[ "$(install_codecs_test)" = "Installed" ]]; then
		show_status "MPlayer codecs already installed"
	else
		file="all-20110131.tar.bz2"
		get="http://www.mplayerhq.hu/MPlayer/releases/codecs/all-20110131.tar.bz2"
		get_file
		tar -jxvf "$file"
		mkdir -p /usr/local/lib/codecs
		cp all-20110131/* /usr/local/lib/codecs
		ln -sf /usr/local/lib/codecs /usr/lib/codecs && ln -sf /usr/local/lib/codecs /usr/local/lib/win32 && ln -sf /usr/local/lib/codecs /usr/lib/win32
	fi
else
	show_warn "Skipping installation of MPlayer codecs as it is only supported in 32-bit architecture"
fi
# Remove possible defective thumbnails
rm -rf "$homedir/.thumbnails/*"
[[ "$(install_codecs_test)" = "Installed" || "$(install_codecs_test)" = "Partial" ]]; exit_state
}

install_codecs_test() {
if [[ -d /usr/lib/gstreamer-0.10 && -d /usr/local/lib/codecs ]]; then
	printf "Installed"
elif [[ -d /usr/lib/gstreamer-0.10 && ! -d /usr/local/lib/codecs ]]; then
	printf "Partial"
else
	printf "Not installed"
fi
}
