function I_F_InstallJupiter # Install Jupiter Applet
{
InstallJupiter
}

function InstallJupiter()
{
ShowFunc "Installing Jupiter"
if [ -e /usr/bin/jupiter ]; then
StatusMsg "Jupiter already installed"
else
file32="jupiter-0.1.2-1.noarch.rpm"
get32="http://master.dl.sourceforge.net/project/jupiter/jupiter-0.1.2-1.noarch.rpm"
file64="$file32"
get64="$get32"
ProcessPkg
fi
if [ -e /usr/bin/jupiter ]; then
Success
else
Failure
fi
}
