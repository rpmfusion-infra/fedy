# Name: Install Cinnamon desktop
# Command: install_cinnamon
# Value: False

install_cinnamon() {
show_func "Installing Cinnamon desktop"
if [[ "$(install_cinnamon_test)" = "Installed" ]]; then
	show_status "Cinnamon desktop already installed"
else
	add_repo fedora-cinnamon.repo
	install_pkg cinnamon
fi
[[ "$(install_cinnamon_test)" = "Installed" ]]; exit_state
}

install_cinnamon_test() {
if [[ -f /usr/bin/cinnamon ]]; then
	printf "Installed"
else
	printf "Not installed"
fi
}
