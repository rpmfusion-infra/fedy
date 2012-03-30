function U_T_SELinuxConf # Set SELinux to permissive mode
{
SELinuxConf
}

function SELinuxConf()
{
ShowFunc "Setting SELinux to permissive mode"
s=`cat /etc/selinux/config | grep -i "SELINUX=permissive"`
if [ -n "$s" ]; then
StatusMsg "SELinux is already in permissive mode"
else
	s=`cat /etc/selinux/config | grep -i "SELINUX=disabled"`
	if [ -n "$s" ]; then
	StatusMsg "SELinux is disabled, not changing state"
	else
	SELinuxPerm
	fi
fi
}

function SELinuxPerm()
{
if [ "$KEEPBACKUP" = "YES" ]; then
cp /etc/selinux/config /etc/selinux/config.bak
fi
sed -i 's/SELINUX=enforcing/SELINUX=permissive/g' /etc/selinux/config
s=`cat /etc/selinux/config | grep -i "SELINUX=permissive"`
if [ -n "$s" ]; then
Success
else
Failure
fi
}
