# Name: Install Viber
# Command: viber_linux
 
viber_linux() {
show_func "Installing Viber"
if [[ "$(viber_linux_test)" = "Installed" ]]; then
	show_status "Viber already installed"
else
	show_msg "Getting latest version"
	get="https://download.cdn.viber.com/desktop/Linux/viber.rpm"
	file="viber.rpm"
	get_file
	if [[ -f "$file" ]]; then
		show_msg "Installing files"
		install_pkg "$file"		
	fi
fi
[[ "$(viber_linux_test)" = "Installed" ]]; exit_state
}
 
viber_linux_undo() {
show_func "Uninstalling Viber"
erase_pkg viber
[[ ! "$(viber_linux_test)" = "Installed" ]]; exit_state
}

viber_linux_hide() {
if [[ ! "$arch" = "64" ]]; then
    printf "true"
fi
}
 
viber_linux_test() {
query_pkg viber
if [[ $? -eq 0 ]]; then
printf "Installed"
else
printf "Not installed"
fi
} 
