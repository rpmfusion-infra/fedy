# Name: Set SELinux to permissive mode
# Command: selinuxconf
# Value: True

selinuxconf() {
show_func "Setting SELinux to permissive mode"
if [[ `grep "SELINUX=permissive" /etc/selinux/config` ]]; then
	show_status "SELinux is already in permissive mode"
else
	if [[ `grep "SELINUX=disabled" /etc/selinux/config` ]]; then
		show_status "SELinux is disabled, not changing state"
	else
		make_backup "/etc/selinux/config"
		sed -i 's/SELINUX=enforcing/SELINUX=permissive/g' /etc/selinux/config
	fi
fi
[[ `grep "SELINUX=permissive" /etc/selinux/config` || `grep "SELINUX=disabled" /etc/selinux/config` ]]; exit_state
}
