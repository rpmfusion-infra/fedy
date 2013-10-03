# Name: Add a repo file
# Command: add_repofile

add_repofile() {
repouri=$(show_dialog --width=700 --height=600 --file-selection --file-filter="*.repo" --title="Select repo file to add" --filename="$homedir/" --button="Cancel:1" --button="Select:0")
if [[ $? -eq 0 ]]; then
	config_repo "$repouri"
fi
}
