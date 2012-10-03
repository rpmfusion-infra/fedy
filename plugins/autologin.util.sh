# Name: Enable autologin
# Command: autologin
# Value: False

auto_login() {
show_func "Enabling autologin"
if [[ `grep "AutomaticLoginEnable=True" /etc/gdm/custom.conf` ]]; then
	show_status "Autologin already enabled"
else
make_backup "/etc/gdm/custom.conf"
cat <<EOF | tee -a "/etc/gdm/custom.conf"
[daemon]
AutomaticLogin=$user
AutomaticLoginEnable=True
EOF
fi
[[ `grep "AutomaticLoginEnable=True" /etc/gdm/custom.conf` ]]; exit_state
}
