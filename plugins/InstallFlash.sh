function U_T_InstallFlash # Install Adobe flash plugin
{
InstallFlash
}

function InstallFlash()
{
ShowFunc "Installing flash plugin"
if [ -f /usr/lib64/mozilla/plugins/libflashplayer.so ] || [ -f /usr/lib/mozilla/plugins/libflashplayer.so ]; then
StatusMsg "Flash plugin already installed"
else
AdobeRepo
yum -y install flash-plugin
fi
if [ -f /usr/lib64/mozilla/plugins/libflashplayer.so ] || [ -f /usr/lib/mozilla/plugins/libflashplayer.so ]; then
Success
else
Failure
fi
}
