# Name: View help
# Command: view_help

view_help() {
while shell=$(zenity --list --radiolist --width=300 --height=300 --title="$program Help" --text="$program $version (C) Satyajit Sahoo\nhttp:\/\/satya164.github.com/fedorautils/" --hide-header --hide-column=2 --column "Select" --column "Command" --column "Options" TRUE "update" "Check update" FALSE "issue" "Report an issue" FALSE "wiki" "Visit the wiki" FALSE "changelog" "View changelog" FALSE "logfile" "View logfile" --ok-label="Select" --cancel-label="Back"); do
	arr=$(echo $shell | tr "|" "\n")
	for x in $arr; do
		case $x in
		"update")
			show_msg "Checking update..."
			show_update
			if [[ "$updatestat" = "uptodate" ]]; then
				show_msg "Fedora Utils is up-to-date"
				zenity --info --timeout="5" --title="Fedora Utils is up-to-date" --text="Fedora Utils is already the latest stable version."
			elif [[ ! "$updatestat" = "available" ]]; then
				show_warn "Could not check update"
				zenity --error --title="Could not check update" --text="An error occured and Fedora Utils was unable to check for update."
			fi;;
		"issue")
			show_msg "Opening Browser..."
			sudo -u "$user"  xdg-open "http://github.com/satya164/fedorautils/issues/new";;
		"wiki")
			show_msg "Opening Browser..."
			sudo -u "$user"  xdg-open "http://github.com/satya164/fedorautils/wiki";;
		"changelog")
			show_msg "Fetching changelog..."
			get_file_quiet "https://raw.github.com/satya164/fedorautils/master/CHANGELOG" "changelog.txt"
			if [[ -f changelog.txt ]]; then
				zenity --text-info --width=600 --height=600 --title="Changelog" --filename="changelog.txt" --ok-label="Ok" --cancel-label="Back"
				rm -f changelog.txt
			else
				show_error "Error fetching changelog! Do you have an active internet connection?"
			fi;;
		"logfile")
			if [[ -f "$logfile" ]]; then
				zenity --text-info --width=600 --height=600 --title="Logfile" --filename="$logfile" --ok-label="Ok" --cancel-label="Back"
			else
				show_error "No logfile exists. Try running fedorautils with logging enabled. Use --help for more details"
			fi;;
		esac
	done
done
}
