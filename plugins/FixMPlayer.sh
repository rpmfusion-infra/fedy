function P_F_FixMPlayer # Fix MPlayer driver error
{
FixMPlayer
}

function FixMPlayer()
{
ShowFunc "Fixing MPlayer video driver error"
s=`cat /etc/mplayer/mplayer.conf | grep "#vo=xv"`
if [ ! -n "$s" ]; then
StatusMsg "Seems that a default driver is already specified for MPlayer"
else
	if [ "$KEEPBACKUP" = "YES" ]; then
	cp /etc/mplayer/mplayer.conf /etc/mplayer/mplayer.conf.bak
	fi
sed -i 's/#vo=xv/vo=xv/g' /etc/mplayer/mplayer.conf
fi
s=`cat /etc/mplayer/mplayer.conf | grep "#vo=xv"`
if [ ! -n "$s" ]; then
Success
else
Failure
fi
}
