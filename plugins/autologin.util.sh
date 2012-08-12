# Name: Enable autologin
# Command: autologin
# Value: False

auto_login() {
show_func "Enabling autologin"
s=`grep "AutomaticLoginEnable=True" /etc/gdm/custom.conf`
if [[ -n "$s" ]]; then
show_status "Autologin already enabled"
else
if [[ "$keepbackup" = "yes" ]]; then
cp /etc/gdm/custom.conf /etc/gdm/custom.conf.bak
fi
cat <<EOF | tee -a /etc/gdm/custom.conf
[daemon]
AutomaticLogin=$user
AutomaticLoginEnable=True
EOF
fi
s=`grep "AutomaticLoginEnable=True" /etc/gdm/custom.conf`
[[ -n "$s" ]]; exit_state
}
