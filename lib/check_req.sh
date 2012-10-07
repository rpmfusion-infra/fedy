check_req() {
show_func "Verifying minimum system requirements"
# Check Distro
if [[ -f "/etc/issue" ]]; then
	show_msg "$(cat /etc/issue | head -n 1) detected"
else
	show_warn "Could not detect distro"
fi
if [[ -f "/etc/issue" ]] && [[ -d "$supportdir" ]] && [[ `grep -iw "$(ls $supportdir)" /etc/issue` ]]; then
	show_status "Distro verified"
	if [[ -f "/etc/fedora-release" ]]; then
		fver="$(grep -ow -E [[:digit:]]+ /etc/fedora-release)"
		show_msg "Fedora version $fver detected"
	else
		show_warn "Could not detect Fedora version"
	fi
else
	if [[ "$forcedistro" = "yes" ]]; then
		show_warn "Unsupported distro, but will continue as instructed"
	else
		show_error "Distro not supported"
		terminate_program
	fi
fi

# Check Architecture
case `uname -m` in
	i386|i486|i586|i686)
		arch="32"
		show_status "Architecture verified (32-bit)";;
	x86_64)
		arch="64"
		show_status "Architecture verified (64-bit)";;
	*)
		show_error "Architecture not supported"
		terminate_program;;
esac
# Check Connection
ping -c 1 www.google.com > /dev/null 2>&1
if [[ $? -eq 0 ]]; then
	show_status "Internet connection verified"
else
	show_warn "No working internet connection found"
	[[ -f /usr/bin/zenity ]] && [[ "$interactive" = "no" ]] || zenity --warning --timeout="5" --title="No working internet connection found" --text="$program requires internet connection to work properly.\nYou may encounter problems."
fi
# Check zenity
if [[ -f /usr/bin/zenity ]]; then
	show_status "zenity verified"
else
	show_error "zenity is needed for $program to run properly. Installing zenity"
	install_pkg zenity
	if [[ ! -f /usr/bin/zenity ]]; then
		show_error "Installation of zenity failed"
		terminate_program
	fi
fi
# Check Curl
if [[ -f /usr/bin/curl ]]; then
	show_status "curl verified"
else
	show_error "curl is needed for $program to run properly. Installing curl"
	install_pkg curl
	if [[ -f /usr/bin/curl ]]; then
		show_error "Installation of curl failed"
		terminate_program
	fi
fi
# Check Wget
if [[ "$prefwget" = "yes" ]] && [[ -f /usr/bin/wget ]]; then
	downagent="wget"
fi
if [[ "$downagent" = "wget" ]]; then
	if [[ ! -f /usr/bin/wget ]]; then
		show_error "wget is not present in the system. Installing wget"
		install_pkg wget
		if [[ ! -f /usr/bin/wget ]]; then
			show_error "Installation of wget failed. Using curl"
			downagent="curl"
		fi
	elif [[ -f /usr/bin/wget ]]; then
		show_status "wget verified"
		show_msg "Using wget"
	fi
fi
}
