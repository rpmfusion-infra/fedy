# Name: Setup sudo for current user
# Command: add_sudoer

add_sudoer() {
show_func "Setting up sudo access for $user"
if [[ "$(add_sudoer_test)" = "Configured" ]]; then
	show_status "Sudo access exists"
else
	make_backup "/etc/sudoers"
	su -c "echo '$user ALL=(ALL) ALL' >> /etc/sudoers"
fi
[[ "$(add_sudoer_test)" = "Configured" ]]; exit_state
}

add_sudoer_test() {
if [[ `sudo -l -U "$user" 2>&1 | grep "ALL"` ]]; then
	printf "Configured"
else
	printf "Not configured"
fi
}
