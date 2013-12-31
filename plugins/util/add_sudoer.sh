# Name: Configure sudo for current user
# Command: add_sudoer

add_sudoer() {
show_func "Configuring sudo access for $user"
if [[ "$(add_sudoer_test)" = "Configured" ]]; then
    show_status "Sudo access exists"
else
    su -c "usermod -G wheel $user"
fi
[[ "$(add_sudoer_test)" = "Configured" ]]; exit_state
}

add_sudoer_undo() {
show_func "Removing sudo access for $user"
gpasswd -d $user wheel
[[ ! "$(add_sudoer_test)" = "Configured" ]]; exit_state
}

add_sudoer_test() {
if [[ `sudo -l -U "$user" 2>&1 | grep "ALL"` ]]; then
    printf "Configured"
else
    printf "Not configured"
fi
}
