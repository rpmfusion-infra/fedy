# Name: Install Cinnamon desktop
# Command: install_cinnamon
# Value: False

install_cinnamon() {
show_func "Installing Cinnamon desktop"
if [[ -d /usr/share/doc/cinnamon* ]]; then
show_status "Cinnamon desktop already installed"
else
cinnamonrepo
install_pkg cinnamon
fi
[[ -d /usr/share/doc/cinnamon* ]]; exit_state
}
