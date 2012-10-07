# Name: Install Jupiter Applet
# Command: install_jupiter
# Value: False

install_jupiter() {
show_func "Installing Jupiter"
if [[ "$(install_jupiter_test)" = "Installed" ]]; then
	show_status "Jupiter already installed"
else
	show_msg "Fetching webpage..."
	get_file_quiet "http://www.jupiterapplet.org/downloads.html" "download.html"
	get32=$(grep "Jupiter RPM" "download.html" | tr " " "\n" | grep ".rpm" | cut -d\" -f 2 | cut -d/ -f 7 | head -n 1 | sed -e 's/^/http:\/\/master.dl.sourceforge.net\/project\/jupiter\//')
	file32=${get32##*/}
	get64="$get32"
	file64=${get64##*/}
	process_pkg
fi
[[ "$(install_jupiter_test)" = "Installed" ]]; exit_state
}

install_jupiter_test() {
if [[ -f /usr/bin/jupiter ]]; then
	printf "Installed"
else
	printf "Not installed"
fi
}
