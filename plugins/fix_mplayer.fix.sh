# Name: Fix MPlayer driver error
# Command: fix_mplayer
# Value: False

fix_mplayer() {
show_func "Fixing MPlayer video driver error"s=`cat /etc/mplayer/mplayer.conf | grep "#vo=xv"`
if [[ ! -n "$s" ]]; then
show_status "Seems that a default driver is already specified for MPlayer"
else
	if [[ "$keepbackup" = "yes" ]]; then
	cp /etc/mplayer/mplayer.conf /etc/mplayer/mplayer.conf.bak
	fi
sed -i 's/#vo=xv/vo=xv/g' /etc/mplayer/mplayer.conf
fi
s=`cat /etc/mplayer/mplayer.conf | grep "#vo=xv"`
[[ ! -n "$s" ]]; exit_state
}
