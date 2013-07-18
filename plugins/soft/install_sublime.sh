# Name: Install Sublime Text 3
# Command: install_sublime

install_sublime() {
show_func "Installing Sublime Text 3"
if [[ "$(install_sublime_test)" = "Installed" && ! "$reinstall" = "yes" ]]; then
  show_status "Sublime Text already installed."
else
	show_msg "Fetching script..."
	get_file_quiet "http://commondatastorage.googleapis.com/xenodecdn%2Fsublime3sh.tar.gz" "sublime3sh.tar.gz"
	tar -xvf sublime3sh.tar.gz
	if [[ "$arch" = "32" ]]; then
		chmod +x sublime-text-3-i686.sh
		./sublime-text-3-i686.sh
		clean_temp
	elif [[ "$arch" = "64" ]]; then
		chmod +x sublime-text-3-x86_64.sh
		./sublime-text-3-x86_64.sh
		clean_temp
	fi
fi
[[ "$(install_sublime_test)" = "Installed" ]]; exit_state
}

install_sublime_test() {
if [[ -f /usr/local/bin/subl ]]; then
	printf "Installed"
else
	printf "Not installed"
fi
}
