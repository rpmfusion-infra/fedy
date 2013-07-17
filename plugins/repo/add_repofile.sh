# Name: Add a repo file
# Command: add_repofile

add_repofile() {
repouri=$(zenity --title="Select repo file to add" --file-selection --file-filter="*.repo")
if [[ $? -eq 0 ]]; then
	config_repo "$repouri"
fi
}
