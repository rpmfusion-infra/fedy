function I_F_GTalk # Install GTalk plugin
{
InstallGTalk
}

function InstallGTalk()
{
ShowFunc "Installing Google Talk plugin"
if [ -d /opt/google/talkplugin ]; then
StatusMsg "Google Talk plugin already installed"
else
file32="google-talkplugin_current_i386.rpm"
get32="http://dl.google.com/linux/direct/google-talkplugin_current_i386.rpm"
file64="google-talkplugin_current_x86_64.rpm"
get64="http://dl.google.com/linux/direct/google-talkplugin_current_x86_64.rpm"
ProcessPkg
fi
if [ -d /opt/google/talkplugin ]; then
Success
else
Failure
fi
}
