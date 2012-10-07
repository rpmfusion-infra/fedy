# Name: Install Jupiter Applet
# Command: install_jupiter
# Value: False

install_jupiter() {
show_func "Installing Jupiter"
if [[ "$(install_jupiter_test)" = "Installed" ]]; then
	show_status "Jupiter already installed"
else
	file32="jupiter-0.1.7-1.noarch.rpm"
	get32="http://master.dl.sourceforge.net/project/jupiter/jupiter-0.1.7-1.noarch.rpm"
	file64="$file32"
	get64="$get32"
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
