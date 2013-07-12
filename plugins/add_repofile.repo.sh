# Name: Add a repo file
# Command: add_repofile

add_repofile() {
repofile=$(zenity --title="Select repo file to add" --file-selection --file-filter="*.repo")
if [[ $? -eq 0 ]]; then
	repofilename=${repofile##*/}
	show_func "Adding $repofilename"
	if [[ -f /etc/yum.repos.d/$repofilename ]]; then
		show_status "$repofilename already present"
	else
		cp -f "$repofile" /etc/yum.repos.d/
	fi
	[[ -f /etc/yum.repos.d/$repofilename ]]; exit_state
fi
}
