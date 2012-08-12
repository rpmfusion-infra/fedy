# Name: Install Jupiter Applet
# Command: install_jupiter
# Value: False

install_jupiter() {
show_func "Installing Jupiter"
if [[ -e /usr/bin/jupiter ]]; then
show_status "Jupiter already installed"
else
file32="jupiter-0.1.2-1.noarch.rpm"
get32="http://master.dl.sourceforge.net/project/jupiter/jupiter-0.1.2-1.noarch.rpm"
file64="$file32"
get64="$get32"
process_pkg
fi
[[ -e /usr/bin/jupiter ]]; exit_state
}
