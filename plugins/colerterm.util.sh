# Name: Add colors to Terminal
# Command: colorterm
# Value: True

colorterm() {
show_func "Enabling colors in Terminal"
if [[ `grep "# Colors in Terminal" /etc/bashrc` ]]; then
	show_status "Colors already added"
else
make_backup "/etc/bashrc"
cat <<EOF | tee -a /etc/bashrc
# Colors in Terminal
if [ \$USER = root ]; then
	PS1='\[\033[1;31m\][\u@\h \W]\\$\[\033[0m\] '
else
	PS1='\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\W\[\033[00m\]\[\033[1;32m\]\\$\[\033[m\] '
fi
EOF
fi
[[ `grep "# Colors in Terminal" /etc/bashrc` ]]; exit_state
}
