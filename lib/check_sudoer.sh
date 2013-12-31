check_sudoer() {
show_msg "Checking sudo access for $user"
if [[ `sudo -l -U "$user" 2>&1 | grep "ALL"` ]]; then
    show_status "Sudo access exists"
else
    show_dialog --title="Add you to the wheel group?" --text="Adding yourself to wheel group will enable you to perform operations as root with sudo. Do you want $program to add $user to the wheel group? You might need to enter the root password in the Terminal." --button="No:1" --button="Yes:0"
    if [[ $? -eq 0 ]]; then
        su -c "usermod -G wheel $user"
    else
        show_msg "As you wish, I was just helping"
        terminate_program
    fi
fi
}
