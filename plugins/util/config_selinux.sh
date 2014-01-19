# Name: Set SELinux to permissive mode
# Command: config_selinux

config_selinux() {
show_func "Setting SELinux to permissive mode"
if [[ "$(config_selinux_test)" = "Permissive" && ! "$reinstall" = "yes" ]]; then
    show_status "SELinux is already in permissive mode"
else
    if [[ "$(config_selinux_test)" = "Disabled" ]]; then
        show_status "SELinux is disabled, not changing state"
    else
        make_backup "/etc/selinux/config"
        sed -i 's/SELINUX=.*$/SELINUX=permissive/g' /etc/selinux/config
        setenforce 0
    fi
fi
[[ "$(config_selinux_test)" = "Permissive" || "$(config_selinux_test)" = "Disabled" ]]; exit_state
}

config_selinux_undo() {
show_func "Setting SELinux to enforcing mode"
make_backup "/etc/selinux/config"
sed -i 's/SELINUX=.*$/SELINUX=enforcing/g' /etc/selinux/config
setenforce 1
[[ ! "$(config_selinux_test)" = "Permissive" || "$(config_selinux_test)" = "Disabled" ]]; exit_state
}

config_selinux_test() {
if [[ `grep "SELINUX=permissive" /etc/selinux/config` ]]; then
    printf "Permissive"
elif [[ `grep "SELINUX=disabled" /etc/selinux/config` ]]; then
    printf "Disabled"
else
    printf "Not configured"
fi
}
