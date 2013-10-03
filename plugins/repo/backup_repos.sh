# Name: Backup repositories
# Command: backup_repos

backup_repos() {
build_repolist "/etc/yum.repos.d/" "true"
repos=$(show_dialog --list --checklist --width=900 --height=600 --title="Select repositories to backup" --no-headers --print-column="2" --column "Select:CHK" --column "Name" --column "Description" --column "Status" --button="Back:1" --button="Backup selected:0" "${repolist[@]}")
if [[ $? -eq 0 ]]; then
	selrepo=$(echo $repos | tr "|" "\n")
	backupfile=$(show_dialog --width=700 --height=600 --file-selection --file-filter="*.tgz" --save --confirm-overwrite="A file with same name already exists. Overwrite file?" --title="Save repositories backup" --filename="$homedir/fedorautils-repobackup-$(date +%s).tgz" --button="Cancel:1" --button="Save:0")
	if [[ $? -eq 0 ]]; then
		show_func "Saving repository backup"
		tar -czf $backupfile --directory="/etc/yum.repos.d/" ${selrepo[@]}
		chown "$user" "$backupfile"
		[[ -f "$backupfile" ]]; exit_state && zenity --info --timeout="5" --title="Saved" --text="Repositories backup saved successfully."
    else
        break
	fi
fi
}
