# Name: Add colors to Terminal
# Command: colorterm
# Value: True

colorterm() {
show_func "Enabling colors in Terminal"
s=`cat /etc/bashrc | grep "# Colors in Terminal"`
if [[ -n "$s" ]]; then
show_status "Colors already added"
else
	if [ "$keepbackup" = "yes" ]; then
	cp /etc/bashrc /etc/bashrc.bak
	fi
cat <<EOF | tee -a /etc/bashrc
# Colors in Terminal
if [ \$USER = root ]; then
	PS1='\[\033[1;31m\][\u@\h \W]\\$\[\033[0m\] '
else
	PS1='\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\W\[\033[00m\]\[\033[1;32m\]\\$\[\033[m\] '
fi
EOF
fi
s=`cat /etc/bashrc | grep "# Colors in Terminal"`
[[ -n "$s" ]]; exit_state
}
