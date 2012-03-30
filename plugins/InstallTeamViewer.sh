function I_F_InstallTeamViewer # Install TeamViewer
{
InstallTeamViewer
}

function InstallTeamViewer()
{
ShowFunc "Installing TeamViewer"
if [ -d /opt/teamviewer/teamviewer ]; then
StatusMsg "TeamViewer already installed"
else
file32="teamviewer_linux.rpm"
get32="http://www.teamviewer.com/download/teamviewer_linux.rpm"
file64="$file32"
get64="$get32"
ProcessPkg
fi
if [ -d /opt/teamviewer/teamviewer ]; then
Success
else
Failure
fi
}
