function S_F_ShellSysMonitor # Install System monitor extension
{
ShellSysMonitor
}

function ShellSysMonitor()
{
ShowFunc "Installing System monitor extension"
if [ -d /usr/share/gnome-shell/extensions/system-monitor@paradoxxx.zero.gmail.com ]; then
StatusMsg "System monitor extension is already installed"
else
InstallGIT
InstallGTKDev
InstallPkg python3 python3-gobject
WarnMsg "We need to compile System monitor extension from source. It may take a while. Please be patient"
git clone https://github.com/paradoxxxzero/gnome-shell-system-monitor-applet.git
cd gnome-shell-system-monitor-applet
./install
cd ..
fi
if [ -d /usr/share/gnome-shell/extensions/system-monitor@paradoxxx.zero.gmail.com ]; then
Success
else
Failure
fi
}
