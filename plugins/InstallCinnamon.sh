function I_F_InstallCinnamon # Install Cinnamon Shell
{
InstallCinnamon
}

function InstallCinnamon()
{
ShowFunc "Installing Cinnamon Shell"
if [ -d /usr/share/doc/cinnamon* ]; then
StatusMsg "Cinnamon already installed"
else
CinnamonRepo
yum -y install cinnamon
fi
if [ -d /usr/share/doc/cinnamon* ]; then
Success
else
Failure
fi
}
