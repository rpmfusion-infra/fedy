# Name: View help
# Command: view_help

view_help() {
detect_repotext
while shell=$(zenity --list --radiolist --width=300 --height=300 --title="$program Help" --text="$program $version (C) Satyajit Sahoo\nhttp:\/\/satya164.github.com/fedorautils/" --hide-header --hide-column=2 --column "Select" --column "Command" --column "Options" TRUE "repo" "$repotext fedorautils repo" FALSE "issue" "Report an issue" FALSE "wiki" "Visit the wiki" FALSE "changelog" "View changelog" FALSE "logfile" "View logfile" --ok-label="Select" --cancel-label="Back"); do
	arr=$(echo $shell | tr "|" "\n")
	for x in $arr; do
		case $x in
		"repo")
			if [[ $repotext = "Remove" ]]; then
				rm -f /etc/yum.repos.d/fedorautils.repo
			else
				add_repo fedorautils.repo
			fi
			detect_repotext;;
		"issue")
			show_msg "Opening Browser..."
			sudo -u "$user"  xdg-open "http://github.com/satya164/fedorautils/issues";;
		"wiki")
			show_msg "Opening Browser..."
			sudo -u "$user"  xdg-open "http://github.com/satya164/fedorautils/wiki";;
		"changelog")
			show_msg "Fetching changelog..."
			curl -s https://raw.github.com/satya164/fedorautils/master/CHANGELOG -o changelog.txt
			if [[ -e changelog.txt ]]; then
				zenity --text-info --width=600 --height=600 --title="Changelog" --filename="changelog.txt" --ok-label="Ok" --cancel-label="Back"
				rm -f changelog.txt
			else
				show_error "Error fetching changelog! Do you have an active internet connection?"
			fi;;
		"logfile")
			if [[ -e "$logfile" ]]; then
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
	repotext="Remove"
else
	repotext="Add"
fi
}
