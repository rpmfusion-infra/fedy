function InstallBZR()
{
ShowFunc "Installing bzr"
if [ -d /usr/share/doc/bzr* ]; then
StatusMsg "bzr already installed"
else
InstallPkg bzr
fi
if [ -d /usr/share/doc/bzr* ]; then
Success
else
Failure
fi
}

function InstallGIT()
{
ShowFunc "Installing git"
if [ -d /usr/share/doc/git* ]; then
StatusMsg "git already installed"
else
InstallPkg git
fi
if [ -d /usr/share/doc/git* ]; then
Success
else
Failure
fi
}

function InstallGTKDev()
{
ShowFunc "Installing developement packages for gtk3"
InstallPkg dbus-glib-devel glib2-devel gnome-common gtk3-devel intltool automake autoconf vala
}
