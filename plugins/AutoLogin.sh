function U_F_AutoLogin # Enable autologin
{
AutoLogin
}

function AutoLogin()
{
ShowFunc "Enabling autologin"
s=`cat /etc/gdm/custom.conf | grep "AutomaticLoginEnable=True"`
if [ -n "$s" ]; then
StatusMsg "Autologin already enabled"
else
cat <<EOF | tee -a /etc/gdm/custom.conf
[daemon]
AutomaticLogin=$USER
AutomaticLoginEnable=True
EOF
fi
s=`cat /etc/gdm/custom.conf | grep "AutomaticLoginEnable=True"`
if [ -n "$s" ]; then
Success
else
Failure
fi
}
