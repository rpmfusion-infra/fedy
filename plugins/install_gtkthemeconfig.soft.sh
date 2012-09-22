# Name: Install GTK theme preferences
# Command: install_gtkthemeconfig
# Value: False

install_gtkthemeconfig() {
show_func "Installing GTK theme preferences"
if [[ -e /usr/bin/gtk-theme-config ]]; then
show_status "GTK theme preferences already installed"
else
install_gtkdev
install_git
git clone https://github.com/satya164/gtk-theme-config.git
cd gtk-theme-config
make install
cd ..
fi
[[ -e /usr/bin/gtk-theme-config ]]; exit_state
}
