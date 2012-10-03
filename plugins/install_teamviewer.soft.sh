# Name: Install TeamViewer
# Command: install_teamviewer
# Value: False

install_teamviewer() {
show_func "Installing TeamViewer"
if [[ -d /opt/teamviewer/teamviewer ]]; then
	show_status "TeamViewer already installed"
else
	file32="teamviewer_linux.rpm"
	get32="http://www.teamviewer.com/download/teamviewer_linux.rpm"
	file64="$file32"
	get64="$get32"
	process_pkg
fi
[[ -d /opt/teamviewer/teamviewer ]]; exit_state
}
