function I_F_InstallSkype # Install Skype
{
InstallSkype
}

function InstallSkype()
{
ShowFunc "Installing Skype"
if [ -e /usr/bin/skype ]; then
StatusMsg "Skype already installed"
else
InstallPkg qt.i686 qt-x11.i686 libXv.i686 libXScrnSaver.i686
file32="skype-2.2.0.35-fedora.i586.rpm"
get32="http://download.skype.com/linux/skype-2.2.0.35-fedora.i586.rpm"
file64="$file32"
get64="$get32"
ProcessPkg
fi
if [ -e /usr/bin/skype ]; then
Success
else
Failure
fi
}
