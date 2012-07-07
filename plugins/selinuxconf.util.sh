# Name: Set SELinux to permissive mode
# Command: selinuxconf
# Value: True

selinuxconf() {
show_func "Setting SELinux to permissive mode"
s=`grep "SELINUX=permissive" /etc/selinux/config`
if [ -n "$s" ]; then
show_status "SELinux is already in permissive mode"
else
	s=`grep "SELINUX=disabled" /etc/selinux/config`
	if [ -n "$s" ]; then
	show_status "SELinux is disabled, not changing state"
	else
		if [ "$keepbackup" = "yes" ]; then
		cp /etc/selinux/config /etc/selinux/config.bak
		fi
		sed -i 's/SELINUX=enforcing/SELINUX=permissive/g' /etc/selinux/config
	fi
fi
s=`grep "SELINUX=permissive" /etc/selinux/config`
[ -n "$s" ]; exit_status
}
