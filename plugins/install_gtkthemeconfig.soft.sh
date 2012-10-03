# Name: Install GTK theme preferences
# Command: install_gtkthemeconfig
# Value: False

install_gtkthemeconfig() {
show_func "Installing GTK theme preferences"
if [[ -e /usr/bin/gtk-theme-config ]]; then
	show_status "GTK theme preferences already installed"
else
	add_repo "gtk-theme-config.repo"
	install_pkg gtk-theme-config
fi
[[ -e /usr/bin/gtk-theme-config ]]; exit_state
}
