# Name: Set SELinux to permissive mode
# Command: config_selinux

config_selinux() {
show_func "Setting SELinux to permissive mode"
if [[ "$(config_selinux_test)" = "Configured" ]]; then
    show_status "SELinux is already in permissive mode"
else
    make_backup "/etc/selinux/config"
    sed -i 's/SELINUX=.*$/SELINUX=permissive/g' /etc/selinux/config
    setenforce 0
fi
[[ "$(config_selinux_test)" = "Configured" ]]; exit_state
}

config_selinux_undo() {
show_func "Setting SELinux to enforcing mode"
make_backup "/etc/selinux/config"
sed -i 's/SELINUX=.*$/SELINUX=enforcing/g' /etc/selinux/config
setenforce 1
[[ ! "$(config_selinux_test)" = "Configured" ]]; exit_state
}

config_selinux_test() {
if [[ `grep "SELINUX=permissive" /etc/selinux/config` ]]; then
    printf "Configured"
else
    printf "Not configured"
fi
}
