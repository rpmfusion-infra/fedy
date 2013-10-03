# Name: Set SELinux to permissive mode
# Command: selinuxconf

selinuxconf() {
show_func "Setting SELinux to permissive mode"
if [[ "$(selinuxconf_test)" = "Permissive" && ! "$reinstall" = "yes" ]]; then
    show_status "SELinux is already in permissive mode"
else
    if [[ "$(selinuxconf_test)" = "Disabled" ]]; then
        show_status "SELinux is disabled, not changing state"
    else
        make_backup "/etc/selinux/config"
        sed -i 's/SELINUX=.*$/SELINUX=permissive/g' /etc/selinux/config
    fi
fi
[[ "$(selinuxconf_test)" = "Permissive" || "$(selinuxconf_test)" = "Disabled" ]]; exit_state
}

selinuxconf_test() {
if [[ `grep "SELINUX=permissive" /etc/selinux/config` ]]; then
    printf "Permissive"
elif [[ `grep "SELINUX=disabled" /etc/selinux/config` ]]; then
    printf "Disabled"
else
    printf "Not configured"
fi
}
