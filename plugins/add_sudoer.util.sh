# Name: Setup sudo for current user
# Command: add_sudoer
# Value: True

add_sudoer() {
show_msg "Checking sudo access for $user"
if [[ "$(core_fonts_test)" = "Configured" ]]; then
	show_status "Sudo access exists"
else
	su -c "echo '$user ALL=(ALL) ALL' >> /etc/sudoers"
fi
}

add_sudoer_test() {
if [[ `sudo -l -U "$user" 2>&1 | grep "ALL"` ]]; then
	printf "Configured"
else
	printf "Not configured"
fi
}
