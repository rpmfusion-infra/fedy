# Name: Install GTK theme preferences
# Command: install_gtkthemeconfig
# Value: False

install_gtkthemeconfig() {
show_func "Installing GTK theme preferences"
if [[ "$(install_gtkthemeconfig_test)" = "Installed" ]]; then
	show_status "GTK theme preferences already installed"
else
	add_repo "gtk-theme-config.repo"
	install_pkg gtk-theme-config
fi
[[ "$(install_gtkthemeconfig_test)" = "Installed" ]]; exit_state
}

install_gtkthemeconfig_test() {
if [[ -f /usr/bin/gtk-theme-config ]]; then
	printf "Installed"
else
	printf "Not installed"
fi
}
