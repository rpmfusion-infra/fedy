function CheckReq()
{
ShowFunc "Verifying minimum system requirements"
# Check Distro
s=`cat /etc/issue | grep -wf "$REMIXSUPPORT"`
if [ -n "$s" ]; then
	StatusMsg "Distro verified"
else
	if [ "$FORCEDISTRO" = "YES" ]; then
	WarnMsg "Unsupported distro, but will continue as instructed"
	else
	ErrorMsg "Distro not supported"
	Terminate
	fi
fi
if [ -e /etc/system-release ]; then
StatusMsg "$(cat /etc/system-release) detected"
fver="$(cat /etc/system-release | cut -c16-17)"
else
WarnMsg "Could not detect Fedora version"
fi
# Check Architecture
if [ $(uname -i) = "i386" ]; then
	StatusMsg "Architecture verified (32-bit)"
elif [ $(uname -i) = "x86_64" ]; then
	StatusMsg "Architecture verified (64-bit)"
else
	ErrorMsg "Architecture not supported"
	Terminate
fi
# Check Connection
i=`ping -c 1 www.google.com > "/dev/null" 2>&1` ;
if [ $? = 0 ]; then
	StatusMsg "Internet connection verified"
else
	WarnMsg "No working internet connection found"
	zenity --warning --timeout="5" --text="No working internet connection found. $PROGRAM requires internet connection to work properly. You may encounter problems."
	INTERNET="NO"
fi
# Check Zenity
if [ -e /usr/bin/zenity ]; then
	StatusMsg "zenity verified"
else
	ErrorMsg "zenity is needed for $PROGRAM to run properly. Installing zenity"
	sudo InstallPkg zenity
	if [ ! -e /usr/bin/zenity ]; then
		ErrorMsg "Installation of zenity failed"
		Terminate
	fi
fi
# Check Curl
if [ -e /usr/bin/curl ]; then
	StatusMsg "curl verified"
else
	ErrorMsg "curl is needed for $PROGRAM to run properly. Installing curl"
	sudo InstallPkg curl
	if [ ! -e /usr/bin/curl ]; then
		ErrorMsg "Installation of curl failed"
		Terminate
	fi
fi
}
