# Name: Setup sudo for current user
# Command: add_sudoer
# Value: True

add_sudoer_test() {
if [[ `sudo -l -U "$user" 2>&1 | grep "ALL"` ]]; then
	printf "Configured"
else
	printf "Not configured"
fi
}
