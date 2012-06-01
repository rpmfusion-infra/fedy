function U_T_ColorTerm # Add colors to Terminal
{
ColorTerm
}

function ColorTerm()
{
ShowFunc "Enabling colours in Terminal"
s=`cat /etc/bashrc | grep "# Colors in Terminal"`
if [ -n "$s" ]; then
StatusMsg "Colors already added"
else
	if [ "$KEEPBACKUP" = "YES" ]; then
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
if [ -n "$s" ]; then
Success
else
Failure
fi
}
