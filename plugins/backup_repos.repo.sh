# Name: Backup repositories
# Command: backup_repos
# Value: False

backup_repos() {
build_repolist "/etc/yum.repos.d/" "true"
repos=$(zenity --list --checklist --width=900 --height=600 --title="Backup repositories" --text="Select repositories to backup." --hide-header --column "Select" --column "Name" --column "Description" --column "Status" --ok-label="Backup" --cancel-label="Cancel" "${repolist[@]}")
if [[ $? -eq 0 ]]; then
	selrepo=$(echo $repos | tr "|" "\n")
	backupfile=$(zenity --title="Save repositories backup" --save --confirm-overwrite --filename="fedorautils-repobackup-$(date +%s).tgz" --file-selection --file-filter="*.tgz")
	if [[ $? -eq 0 ]]; then
		show_func "Saving repository backup"
		tar -czf $backupfile --directory="/etc/yum.repos.d/" ${selrepo[@]}
		chown "$user" "$backupfile"
		[[ -f "$backupfile" ]]; exit_state && zenity --info --timeout="5" --title="Saved" --text="Repositories backup saved successfully."
	fi
fi
}
