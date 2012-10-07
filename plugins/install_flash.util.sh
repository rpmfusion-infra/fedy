# Name: Install Adobe flash plugin
# Command: install_flash
# Value: False

install_flash() {
show_func "Installing Adobe flash plugin"
if [[ "$(install_flash_test)" = "Installed" ]]; then
	show_status "Adobe flash plugin already installed"
else
	add_repo "adobe-linux.repo"
	install_pkg flash-plugin
fi
[[ "$(install_flash_test)" = "Installed" ]]; exit_state
}

install_flash_test() {
if [[ -f /usr/lib64/mozilla/plugins/libflashplayer.so || -f /usr/lib/mozilla/plugins/libflashplayer.so ]]; then
	printf "Installed"
else
	printf "Not installed"
fi
}
