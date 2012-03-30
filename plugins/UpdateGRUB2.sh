function M_F_UpdateGRUB2 # Update GRUB2 config
{
UpdateGRUB2
}

function UpdateGRUB2()
{
ShowFunc "Updating GRUB2 configuration"
g=`dd bs=512 count=1 if=/dev/sda 2>/dev/null | strings | grep "GRUB"`
if [ -n "$g" ] && [ -d /usr/share/doc/grub2* ]; then
grub2-mkconfig -o /boot/grub2/grub.cfg
else
ErrorMsg "GRUB2 doesn't seem to be installed"
fi
if [ $? = "0" ]; then
Success
else
Failure
fi
}
