# Name: Enable DVD playback
# Command: enable_dvd
# Value: False

enable_dvd() {
show_func "Installing DVD codecs"
if [[ "$(enable_dvd_test)" = "Enabled with libdvdcss2" || "$(enable_dvd_test)" = "Enabled" ]]; then
	show_status "DVD codecs already installed"
else
	add_repo "rpmfusion-free.repo" "rpmfusion-nonfree.repo"
	install_pkg libdvdread libdvdnav lsdvd
fi
show_func "Installing libdvdcss2"
if [[ "$(enable_dvd_test)" = "Enabled with libdvdcss2" ]]; then
	show_status "libdvdcss2 already installed"
else
	show_msg "Fetching webpage..."
	get_file_quiet "http://packages.atrpms.net/dist/f17/libdvdcss/" "index.html"
	get32=$(grep "libdvdcss2" index.html | tr " " "\n" | grep "dl.atrpms.net" | grep "i686" | cut -d\" -f 2)
	file32=${get32##*/}
	get64=$(grep "libdvdcss2" index.html | tr " " "\n" | grep "dl.atrpms.net" | grep "x86_64" | cut -d\" -f 2)
	file64=${get64##*/}
	process_pkg
fi
[[ "$(enable_dvd_test)" = "Enabled with libdvdcss2" ]]; exit_state
}

enable_dvd_test() {
if [[ -f /usr/lib/libdvdread.so.4 && -f /usr/lib/libdvdnav.so.4 && -f /usr/bin/lsdvd && -f /usr/lib/libdvdcss.so.2 ]]; then
	printf "Enabled with libdvdcss2"
elif [[ -f /usr/lib/libdvdread.so.4 && -f /usr/lib/libdvdnav.so.4 && -f /usr/bin/lsdvd && ! -f /usr/lib/libdvdcss.so.2 ]]; then
	printf "Enabled"
else
	printf "Not enabled"
fi
}
