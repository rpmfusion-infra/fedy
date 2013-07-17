# Name: Install Skype
# Command: install_skype

install_skype() {
show_func "Installing Skype"
if [[ "$(install_skype_test)" = "Installed" && ! "$reinstall" = "yes" ]]; then
	show_status "Skype already installed"
else
	add_repo "skype.repo"
	show_msg "Installing dependencies..."
	install_pkg alsa-lib.i686 libXv.i686 libXScrnSaver.i686 qt.i686 qt-x11.i686 pulseaudio-libs.i686 pulseaudio-libs-glib2.i686 alsa-plugins-pulseaudio.i686 qtwebkit.i686
	get32="http://download.skype.com/linux/skype-4.2.0.11-fedora.i586.rpm"
	file32="skype-4.2.0.11-fedora.i586.rpm"
	get64="$get32"
	file64="$file32"
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
