check_req() {
show_func "Verifying minimum system requirements"
# Check Distro
s=`grep -iw "$(ls support)" /etc/issue`
if [ -n "$s" ]; then
	show_status "Distro verified"
else
	if [ "$forcedistro" = "yes" ]; then
	show_warn "Unsupported distro, but will continue as instructed"
	else
	show_error "Distro not supported"
	terminate_program
	fi
fi
if [ -e /etc/system-release ]; then
show_msg "$(cat /etc/system-release) detected"
fver="$(cat /etc/system-release | cut -c16-17)"
else
show_warn "Could not detect Fedora version"
fi
# Check Architecture
if [ $(uname -i) = "i386" ]; then
	show_status "Architecture verified (32-bit)"
elif [ $(uname -i) = "x86_64" ]; then
	show_status "Architecture verified (64-bit)"
else
	show_error "Architecture not supported"
	terminate_program
fi
# Check Connection
i=`ping -c 1 www.google.com > "/dev/null" 2>&1` ;
if [ $? = "0" ]; then
	show_status "Internet connection verified"
else
	show_warn "No working internet connection found"
	zenity --warning --timeout="5" --text="No working internet connection found. $program requires internet connection to work properly. You may encounter problems."
fi
# Check Zenity
if [ `which zenity` ]; then
	show_status "zenity verified"
else
	show_error "zenity is needed for $program to run properly. Installing zenity"
	install_pkg zenity
	if [ ! `which zenity` ]; then
		show_error "Installation of zenity failed"
		terminate_program
	fi
fi
# Check Curl
if [ `which curl` ]; then
	show_status "curl verified"
else
	show_error "curl is needed for $program to run properly. Installing curl"
	install_pkg curl
	if [ ! `which curl` ]; then
		show_error "Installation of curl failed"
		terminate_program
	fi
fi
# Check Wget
if [ "$prefwget" = "yes" ] && [ `which wget` ]; then
	downagent="wget"
fi
if [ "$downagent" = "wget" ]; then
	if [ ! `which wget` ]; then
		show_error "wget is not present in the system. Installing wget"
		install_pkg wget
		if [ ! `which wget` ]; then
			show_error "Installation of wget failed. Using curl"
			downagent="curl"
		fi
	elif [ `which wget` ]; then
		show_status "wget verified"
		show_msg "Using wget"
	fi
fi
}
