# Name: Install Adobe flash plugin
# Command: install_flash
# Value: False

install_flash() {
show_func "Installing Adobe flash plugin"
if [[ -f /usr/lib64/mozilla/plugins/libflashplayer.so || -f /usr/lib/mozilla/plugins/libflashplayer.so ]]; then
show_status "Adobe flash plugin already installed"
else
adoberepo
install_pkg flash-plugin
fi
[[ -f /usr/lib64/mozilla/plugins/libflashplayer.so || -f /usr/lib/mozilla/plugins/libflashplayer.so ]]; exit_state
}
