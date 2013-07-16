# Name: Install Google Earth
# Command: install_earth

install_earth() {
show_func "Installing Google Earth"
if [[ "$(install_earth_test)" = "Installed" ]]; then
	show_status "Google Earth already installed"
else
	install_pkg mesa-libGL.i686 bitstream-vera-fonts-common libxml2.i686 gtk2.i686 libSM.i686 qt-x11 redhat-lsb-graphics.i686 redhat-lsb-printing.i686 redhat-lsb.i686
	get32="http://dl.google.com/dl/earth/client/current/google-earth-stable_current_i386.rpm"
	file32="google-earth-stable_current_i386.rpm"
	get64="http://dl.google.com/dl/earth/client/current/google-earth-stable_current_x86_64.rpm"
	file64="google-earth-stable_current_x86_64.rpm"
	process_pkg
fi
[[ "$(install_earth_test)" = "Installed" ]]; exit_state
}

install_earth_test() {
if [[ -f /opt/google/earth/free/googleearth ]]; then
	printf "Installed"
else
	printf "Not installed"
fi
}
