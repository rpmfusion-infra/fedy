# Name: Configure sudo for current user
# Command: config_sudo

config_sudo() {
show_func "Configuring sudo access for $user"
if [[ "$(config_sudo_test)" = "Configured" ]]; then
    show_status "Sudo access exists"
else
    su -c "usermod -G wheel $user"
fi
[[ "$(config_sudo_test)" = "Configured" ]]; exit_state
}

config_sudo_undo() {
show_func "Removing sudo access for $user"
gpasswd -d $user wheel
[[ ! "$(config_sudo_test)" = "Configured" ]]; exit_state
}

config_sudo_test() {
if [[ `sudo -l -U "$user" 2>&1 | grep "ALL"` ]]; then
    printf "Configured"
else
    printf "Not configured"
fi
}
