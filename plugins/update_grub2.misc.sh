# Name: Update GRUB2 config
# Command: update_grub2
# Value: False

update_grub2() {
show_func "Updating GRUB2 configuration"
if [[ -d /boot/grub2 ]]; then
	grub2-mkconfig -o /boot/grub2/grub.cfg
else
	show_error "GRUB2 doesn't seem to be installed"
fi
exit_state
}
