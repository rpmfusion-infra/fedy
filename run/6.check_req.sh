# Run: check_req

check_req() {
show_func "Verifying minimum system requirements"
# Check distro
if [[ -f /etc/fedora-release ]]; then
	fver="$(rpm -E %fedora)"
	show_msg "Fedora version $fver detected"
else
	if [[ "$forcedistro" = "yes" ]]; then
		show_warn "Unsupported distro, but will continue as instructed"
	else
		show_err "Distro not supported!"
		terminate_program
	fi
fi
# Check architecture
case `uname -m` in
	i386|i486|i586|i686)
		arch="32"
		show_status "Architecture verified (32-bit)";;
	x86_64)
		arch="64"
		show_status "Architecture verified (64-bit)";;
	*)
		show_err "Architecture not supported!"
		terminate_program;;
esac
# Check connection
ping -c 1 www.google.com > /dev/null 2>&1
if [[ $? -eq 0 ]]; then
	show_status "Internet connection verified"
else
	show_warn "No working internet connection found"
	[[ -f /usr/bin/yad ]] && [[ "$interactive" = "no" ]] || show_dialog --timeout="5" --title="No working internet connection found" --text="$program requires internet connection to work properly.\nYou may encounter problems." --button="Continue:0"
fi
# Check yad
if [[ -f /usr/bin/yad ]]; then
	show_status "yad verified"
else
	show_err "yad is required for $program to run properly, installing yad"
	install_pkg yad
	if [[ ! -f /usr/bin/yad ]]; then
		show_err "Installation of yad failed!"
		terminate_program
	fi
fi
# Check curl
if [[ -f /usr/bin/curl ]]; then
	show_status "curl verified"
else
	show_err "curl is required for $program to run properly, installing curl"
	install_pkg curl
	if [[ ! -f /usr/bin/curl ]]; then
		show_err "Installation of curl failed!"
		terminate_program
	fi
fi
# Check wget
if [[ "$prefwget" = "yes" ]] && [[ -f /usr/bin/wget ]]; then
	downagent="wget"
fi
if [[ "$downagent" = "wget" ]]; then
	if [[ -f /usr/bin/wget ]]; then
		show_status "wget verified"
		show_msg "Using wget"
	else
		show_err "wget is not present in the system, installing wget"
		install_pkg wget
		if [[ ! -f /usr/bin/wget ]]; then
			show_err "Installation of wget failed, using curl"
			downagent="curl"
		fi
	fi
fi
}
