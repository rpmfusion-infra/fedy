# Name: Install Elegance Colors
# Command: install_elegance
# Value: False

install_elegance() {
show_func "Installing Elegance Colors Gnome Shell theme"
if [[ "$(install_elegance_test)" = "Installed" ]]; then
	show_status "Elegance Colors Gnome Shell theme already installed"
else
	add_repo "elegance-colors.repo"
	install_pkg gnome-shell-theme-elegance-colors
fi
[[ "$(install_elegance_test)" = "Installed" ]]; exit_state
}

install_elegance_test() {
if [[ -f /usr/bin/elegance-colors ]]; then
	printf "Installed"
else
	printf "Not installed"
fi
}
