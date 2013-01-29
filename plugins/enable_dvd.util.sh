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
	add_repo "livna.repo"
	install_pkg --enablerepo=livna libdvdcss
fi
[[ "$(enable_dvd_test)" = "Enabled with libdvdcss2" ]]; exit_state
}

enable_dvd_test() {
ls /usr/lib*/libdvdread.so.4 > /dev/null 2>&1 && ls /usr/lib*/libdvdnav.so.4 > /dev/null 2>&1 && ls /usr/bin/lsdvd > /dev/null 2>&1 && ls /usr/lib*/libdvdcss.so.2 > /dev/null 2>&1
if [[ $? -eq 0 ]]; then
	printf "Enabled"
else
	printf "Not enabled"
fi
}
