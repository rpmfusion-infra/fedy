# Name: Install GTK theme preferences
# Command: install_gtkthemeconfig
# Value: False
# Include: add_repo.util.sh

install_gtkthemeconfig() {
show_func "Installing GTK theme preferences"
if [[ -e /usr/bin/gtk-theme-config ]]; then
show_status "GTK theme preferences already installed"
else
gtkthemeconfigrepo
install_pkg gtk-theme-config
fi
[[ -e /usr/bin/gtk-theme-config ]]; exit_state
}
