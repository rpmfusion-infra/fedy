function I_F_InstallGoogleEarth # Install Google Earth
{
InstallGoogleEarth
}

function InstallGoogleEarth()
{
ShowFunc "Installing Google Earth"
if [ -f /opt/google/earth/free/googleearth ]; then
StatusMsg "Google Earth already installed"
else
InstallPkg mesa-libGL.i686 bitstream-vera-fonts-common libxml2.i686 gtk2.i686 libSM.i686 qt-x11 redhat-lsb-graphics.i686 redhat-lsb-printing.i686 redhat-lsb.i686
file32="google-earth-stable_current_i386.rpm"
get32="http://dl.google.com/dl/earth/client/current/google-earth-stable_current_i386.rpm"
file64="google-earth-stable_current_x86_64.rpm"
get64="http://dl.google.com/dl/earth/client/current/google-earth-stable_current_x86_64.rpm"
ProcessPkg
fi
if [ -f /opt/google/earth/free/googleearth ]; then
Success
else
Failure
fi
}
