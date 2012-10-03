add_sudoer() {
show_msg "Checking sudo access for $user"
echo "$(sudo -l)" >> "checksudo.tmp"
s=`grep "ALL" "checksudo.tmp"`
rm -f "checksudo.tmp"
if [[ -n "$s" ]]; then
	show_status "Sudo access exists"
else
	zenity --question --title="Add you to sudoers list?" --text="Adding yourself to sudoers will enable you to perform operations as root. Do you want $program to add $user to the sudoers list? You will need to enter root password in the Terminal." --ok-label "Yes" --cancel-label "No"
	if [[ $? -eq 0 ]]; then
		su -c "echo '$USER ALL=(ALL) ALL' >> /etc/sudoers"
#		su -c "echo '$USER ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers"
	else
		show_msg "As you wish. I was just helping"
		terminate_program
	fi
fi
}
