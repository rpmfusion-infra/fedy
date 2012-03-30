function U_F_EnableDVD # Enable DVD playback
{
EnableDVD
}

function EnableDVD()
{
DVDCodecs
DVDCss
}

function DVDCodecs()
{
ShowFunc "Installing DVD Codecs"
if [ -d /usr/share/doc/libdvdread* ] && [ -d /usr/share/doc/libdvdnav* ] && [ -d /usr/share/doc/lsdvd* ]; then
StatusMsg "DVD Codecs already installed"
else
RPMFusion
InstallPkg libdvdread libdvdnav lsdvd
fi
if [ -d /usr/share/doc/libdvdread* ] && [ -d /usr/share/doc/libdvdnav* ] && [ -d /usr/share/doc/lsdvd* ]; then
Success
else
Failure
fi
}

function DVDCss()
{
ShowFunc "Installing libdvdcss"
if [ -f /usr/lib/libdvdcss.so.2 ]; then
StatusMsg "libdvdcss already installed"
else
file32="libdvdcss2-1.2.11-6.fc16.i686.rpm"
get32="http://dl.atrpms.net/f16-i386/atrpms/stable/libdvdcss2-1.2.11-6.fc16.i686.rpm"
file64="libdvdcss2-1.2.11-6.fc16.x86_64.rpm"
get64="http://dl.atrpms.net/f16-x86_64/atrpms/stable/libdvdcss2-1.2.11-6.fc16.x86_64.rpm"
ProcessPkg
fi
if [ -f /usr/lib/libdvdcss.so.2 ]; then
Success
else
Failure
fi
}
