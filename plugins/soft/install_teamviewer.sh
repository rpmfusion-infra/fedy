# Name: Install TeamViewer
# Command: install_teamviewer

install_teamviewer() {
show_func "Installing TeamViewer"
if [[ "$(install_teamviewer_test)" = "Installed" && ! "$reinstall" = "yes" ]]; then
	show_status "TeamViewer already installed"
else
	get32="http://www.teamviewer.com/download/teamviewer_linux.rpm"
	file32=${get32##*/}
	get64="$get32"
	file64="$file32"
	process_pkg
fi
[[ "$(install_teamviewer_test)" = "Installed" ]]; exit_state
}

install_teamviewer_test() {
if [[ -f /usr/bin/teamviewer ]]; then
	printf "Installed"
else
	printf "Not installed"
fi
}
