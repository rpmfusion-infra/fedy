function I_F_InstallGoogleChrome # Install Google Chrome
{
InstallGoogleChrome
}

function InstallGoogleChrome()
{
ShowFunc "Installing Google Chrome"
if [ -d /opt/google/chrome ]; then
StatusMsg "Google Chrome already installed"
else
file32="google-chrome-stable_current_i386.rpm"
get32="https://dl.google.com/linux/direct/google-chrome-stable_current_i386.rpm"
file64="google-chrome-stable_current_x86_64.rpm"
get64="http://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm"
ProcessPkg
fi
if [ -d /opt/google/chrome ]; then
Success
else
Failure
fi
}
