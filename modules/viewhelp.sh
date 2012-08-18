# Name: View help
# Command: view_help

view_help() {
detect_repotext
while shell=$(zenity --list --radiolist --width=300 --height=300 --title="$program Help" --text="$program $version (C) Satyajit Sahoo\nhttp:\/\/satya164.github.com/fedorautils/" --hide-header --hide-column=2 --column "Select" --column "Command" --column "Options" TRUE "repo" "$repotext fedorautils repo" FALSE "issue" "Report an issue" FALSE "wiki" "Visit the wiki" FALSE "changelog" "View changelog" FALSE "logfile" "View logfile" --ok-label="Select" --cancel-label="Back"); do
	arr=$(echo $shell | tr "|" "\n")
	for x in $arr; do
		case $x in
		"repo") if [[ $repotext = "Enable" ]]; then
			show_func "Enabling fedorautils repo"
			sed -i 's/enabled=0/enabled=1/g' /etc/yum.repos.d/fedorautils.repo
			elif [[ $repotext = "Disable" ]]; then
			show_func "Disabling fedorautils repo"
			sed -i 's/enabled=1/enabled=0/g' /etc/yum.repos.d/fedorautils.repo
			else
			fedorautilsrepo
			fi
			detect_repotext;;
		"issue") show_msg "Opening Browser..."
				sudo -u "$user"  xdg-open "http://github.com/satya164/fedorautils/issues";;
		"wiki") show_msg "Opening Browser..."
				sudo -u "$user"  xdg-open "http://github.com/satya164/fedorautils/wiki";;
		"changelog") show_msg "Fetching changelog..."
			curl -s https://raw.github.com/satya164/fedorautils/master/CHANGELOG -o changelog.txt
			if [[ -e changelog.txt ]]; then
			zenity --text-info --width=600 --height=600 --title="Changelog" --filename="changelog.txt" --ok-label="Ok" --cancel-label="Back"
			rm -f changelog.txt
			else
			show_error "Error fetching changelog! Do you have an active internet connection?"
			fi;;
		"logfile") if [[ -e "$logfile" ]]; then
			zenity --text-info --width=600 --height=600 --title="Logfile" --filename="$logfile" --ok-label="Ok" --cancel-label="Back"
			else
			show_error "No logfile exists. Try running fedorautils with logging enabled. Use --help for more details"
			fi;;
		esac
	done
done
}

detect_repotext() {
if [[ -e /etc/yum.repos.d/fedorautils.repo ]]; then
e=`grep "enabled=0" /etc/yum.repos.d/fedorautils.repo`
	if [[ -n "$e" ]]; then
	repotext="Enable"
	else
	repotext="Disable"
	fi
else
	repotext="Add"
fi
}

fedorautilsrepo() {
if [[ -f /etc/yum.repos.d/fedorautils.repo ]]; then
show_status "Fedora Utils repo already present"
else
cat <<EOF | tee /etc/yum.repos.d/fedorautils.repo
[fedorautils]
name=Fedora Utils
baseurl=http://master.dl.sourceforge.net/project/fedorautils/
enabled=1
metadata_expire=1d
skip_if_unavailable=1
gpgcheck=0
EOF
fi
}
