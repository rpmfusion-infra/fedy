# Name: Fix MPlayer driver error
# Command: fix_mplayer
# Value: False

fix_mplayer() {
show_func "Fixing MPlayer video driver error"
if [[ ! `cat "/etc/mplayer/mplayer.conf" | grep "#vo=xv"` ]]; then
	show_status "Seems that a default driver is already specified for MPlayer"
else
	make_backup "/etc/mplayer/mplayer.conf"
	sed -i 's/#vo=xv/vo=xv/g' "/etc/mplayer/mplayer.conf"
fi
[[ ! `cat "/etc/mplayer/mplayer.conf" | grep "#vo=xv"` ]]; exit_state
}
