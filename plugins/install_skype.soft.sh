# Name: Install Skype
# Command: install_skype
# Value: False

install_skype() {
show_func "Installing Skype"
if [[ "$(install_skype_test)" = "Installed" ]]; then
	show_status "Skype already installed"
else
	install_pkg qt.i686 qt-x11.i686 libXv.i686 libXScrnSaver.i686
	file32="skype-4.0.0.8-fedora.i586.rpm"
	get32="http://download.skype.com/linux/skype-4.0.0.8-fedora.i586.rpm"
	file64="$file32"
	get64="$get32"
	process_pkg
fi
[[ "$(install_skype_test)" = "Installed" ]]; exit_state
}

install_skype_test() {
if [[ -f /usr/bin/skype ]]; then
	printf "Installed"
else
	printf "Not installed"
fi
}
