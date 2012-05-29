function I_F_InstallHandBrake # Install HandBrake
{
InstallHandBrake
}

function InstallHandBrake()
{
ShowFunc "Installing HandBrake"
if [ -d /usr/share/doc/HandBrake* ]; then
StatusMsg "HandBrake already installed"
else
	if [ "$fver" = "17" ] || [ "$fver" = "16" ]; then
	file32="HandBrake-gui-0.9.6-1.fc16.i686.rpm"
	get32="http://master.dl.sourceforge.net/project/handbrake/0.9.6/HandBrake-gui-0.9.6-1.fc16.i686.rpm"
	file64="HandBrake-gui-0.9.6-1.fc16.x86_64.rpm"
	get64="http://master.dl.sourceforge.net/project/handbrake/0.9.6/HandBrake-gui-0.9.6-1.fc16.x86_64.rpm"
	ProcessPkg
	else
	WarnMsg "HandBrake is not available for your Fedora version"
	fi
fi
if [ -d /usr/share/doc/HandBrake* ]; then
Success
else
Failure
fi
}
