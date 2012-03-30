function U_T_AddSudoer # Setup sudo for current user
{
AddSudoer
}

function AddSudoer()
{
ShowMsg "Checking sudo access for $USER"
echo "$(sudo -l)" >> checksudo.tmp
r=`cat checksudo.tmp | grep "(ALL)"`
rm -f checksudo.tmp
if [ -n "$r" ]; then
	StatusMsg "Sudo access exists"
else
	zenity --question --title="Add you to sudoers list?" --text="Adding yourself to sudoers will enable you to perform operations as root. Do you want $PROGRAM to add $USER to the sudoers list? You will need to enter root password in the Terminal." --ok-label "Yes" --cancel-label "No"
	if [ ! $? == 1 ]; then
	su -c "echo '$USER ALL=(ALL) ALL' >> /etc/sudoers"
	#su -c "echo '$USER ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers"
	Done
	else
	echo -e "As you wish. I was just helping"
	Terminate
	fi
fi
}
