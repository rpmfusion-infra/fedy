function U_F_FortuneTerm # Add fortune messages to terminal
{
FortuneTerm
}

function FortuneTerm()
{
ShowFunc "Enabling fortune messsages in Terminal"
RPMFusion
if [ ! -e /usr/bin/fortune ]; then
InstallPkg fortune-mod
fi
s=`cat /etc/bashrc | grep -i "# Display Fortune"`
if [ -n "$s" ]; then
StatusMsg "Fortune already installed"
else
	if [ "$KEEPBACKUP" = "YES" ]; then
	cp /etc/bashrc /etc/bashrc.bak
	fi
cat <<EOF | tee -a /etc/bashrc
# Display Fortune
if [ "\$PS1" ]; then
fortune
fi
EOF
fi
s=`cat /etc/bashrc | grep -i "# Display Fortune"`
if [ -n "$s" ] && [ -e /usr/bin/fortune ]; then
Success
else
Failure
fi
}
