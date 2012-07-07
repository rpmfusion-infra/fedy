# Name: View help
# Command: view_help

view_help() {
if [ -e /etc/yum.repos.d/fedorautils.repo ]; then
repotext="Remove"
else
repotext="Add"
fi
while shell=$(zenity --list --width=300 --height=300 --title="$program Help" --text="$program $version (C) Satyajit Sahoo\nhttp:\/\/satya164.github.com/fedorautils/" --radiolist  --column "Select" --column "Options" TRUE "$repotext fedorautils repo" FALSE "Report an issue" FALSE "Visit the wiki" FALSE "View changelog" FALSE "View logfile" --ok-label="Select" --hide-header --cancel-label="Back"); do
	arr=$(echo $shell | tr "|" "\n")
	for x in $arr; do
		case $x in
		"repo") if [ -e /etc/yum.repos.d/fedorautils.repo ]; then
			show_func "Removing fedorautils repo"
			rm -f /etc/yum.repos.d/fedorautils.repo
			else
			show_func "Adding fedorautils repo"
				FedoraUtilsRepo
			fi;;
		"issue") show_msg "Opening Browser..."
				sudo -u "$user"  xdg-open "http://github.com/satya164/fedorautils/issues";;
		"wiki") show_msg "Opening Browser..."
				sudo -u "$user"  xdg-open "http://github.com/satya164/fedorautils/wiki";;
		"changelog") show_msg "Fetching changelog..."
			curl -s https://raw.github.com/satya164/fedorautils/master/CHANGELOG -o changelog.txt
			if [ -e changelog.txt ]; then
			zenity --text-info --width=600 --height=600 --title="Changelog" --filename="changelog.txt" --ok-label="Ok" --cancel-label="Back"
			rm -f changelog.txt
			else
			show_error "Error fetching changelog! Do you have an active internet connection?"
			fi;;
		"logfile") if [ -e "$logfile" ]; then
			zenity --text-info --width=600 --height=600 --title="Logfile" --filename="$logfile" --ok-label="Ok" --cancel-label="Back"
			else
			show_error "No logfile exists. Try running fedorautils with logging enabled. Use --help for more details"
			fi;;
		esac
	done
done
}
