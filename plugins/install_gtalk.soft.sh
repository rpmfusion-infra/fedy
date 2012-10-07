# Name: Install GTalk plugin
# Command: install_gtalk
# Value: False

install_gtalk() {
show_func "Installing GTalk plugin"
if [[ "$(install_gtalk_test)" = "Installed" ]]; then
	show_status "GTalk plugin already installed"
else
	get32="http://dl.google.com/linux/direct/google-talkplugin_current_i386.rpm"
	file32="google-talkplugin_current_i386.rpm"
	get64="http://dl.google.com/linux/direct/google-talkplugin_current_x86_64.rpm"
	file64="google-talkplugin_current_x86_64.rpm"
	process_pkg
fi
[[ "$(install_gtalk_test)" = "Installed" ]]; exit_state
}

install_gtalk_test() {
if [[ -f /opt/google/talkplugin/GoogleTalkPlugin ]]; then
	printf "Installed"
else
	printf "Not installed"
fi
}
