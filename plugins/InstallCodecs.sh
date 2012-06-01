function U_T_InstallCodecs # Install multimedia codecs
{
InstallCodecs
}

function InstallCodecs()
{
ShowFunc "Installing multimedia codecs"
if [ -d /usr/share/doc/gstreamer-plugins-ugly* ]; then
StatusMsg "GStreamer plugins already installed"
else
RPMFusion
InstallPkg gstreamer-plugins-good gstreamer-plugins-bad gstreamer-plugins-bad-free gstreamer-plugins-bad-nonfree gstreamer-plugins-ugly gstreamer-ffmpeg faac faad2 libdca libmad libmatroska xvidcore
fi
if ( [ "$(pidof ksmserver)" ] ); then
InstallPkg vlc phonon-backend-vlc
else
InstallPkg gnome-mplayer
fi
# Install MPlayer Codecs if Architecture is 32-bit
if [ $(uname -i) = "i386" ]; then
	if [ -d /usr/local/lib/codecs ]; then
	StatusMsg "MPlayer codecs already installed"
	else
	file="all-20110131.tar.bz2"
	get="http://www.mplayerhq.hu/MPlayer/releases/codecs/all-20110131.tar.bz2"
	GetFile
	tar -jxvf "$file"
	mkdir -p /usr/local/lib/codecs
	cp all-20110131/* /usr/local/lib/codecs
	ln -sf /usr/local/lib/codecs /usr/lib/codecs && ln -sf /usr/local/lib/codecs /usr/local/lib/win32 && ln -sf /usr/local/lib/codecs /usr/lib/win32
	fi
else
	WarnMsg "Skipping installation of MPlayer codecs as it is only supported in 32-bit architecture"
fi
# Remove possible defective thumbnails
rm -rf "$HOMEDIR/.thumbnails/*"
if [ -d /usr/share/doc/gstreamer-plugins-ugly* ] && [ -d /usr/local/lib/codecs ]; then
Success
else
Failure
fi
}
