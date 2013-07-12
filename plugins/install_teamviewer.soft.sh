# Name: Install TeamViewer
# Command: install_teamviewer

install_teamviewer() {
show_func "Installing TeamViewer"
if [[ "$(install_teamviewer_test)" = "Installed" ]]; then
	show_status "TeamViewer already installed"
else
	get32="http://www.teamviewer.com/download/teamviewer_linux.rpm"
	file32="teamviewer_linux.rpm"
	get64="$get32"
	file64="$file32"
	process_pkg
fi
[[ "$(install_teamviewer_test)" = "Installed" ]]; exit_state
}

install_teamviewer_test() {
if [[ -d /opt/teamviewer/teamviewer ]]; then
	printf "Installed"
else
	printf "Not installed"
fi
}
