# Name: Backup repositories
# Command: backup_repos
# Value: False

backup_repos() {
unset repolist
repofiles=($(ls /etc/yum.repos.d/))
for repofile in ${repofiles[@]}; do
	repodesc=$(grep "name=" "/etc/yum.repos.d/$repofile" | head -n 1 | sed -e 's/^name=//g' -e s/\$releasever/$fver/g -e s/\$basearch/$(uname -i)/g)
	repolist=( "${repolist[@]}" TRUE "$repofile" "$repodesc" )
done
repos=$(zenity --list --checklist --width=900 --height=600 --title="Backup repositories" --text="Select repositories to backup." --hide-header --column "Select" --column "Name" --column "Description" --ok-label="Backup" --cancel-label="Cancel" "${repolist[@]}")
if [[ $? -eq 0 ]]; then
	selrepo=$(echo $repos | tr "|" "\n")
	backupfile=$(zenity --title="Save repositories backup" --save --confirm-overwrite --filename="fedorautils-repobackup-$(date +%s).tgz" --file-selection --file-filter="*.tgz")
	if [[ $? -eq 0 ]]; then
		tar -czf $backupfile --directory="/etc/yum.repos.d/" ${selrepo[@]}
		chown "$user" "$backupfile"
		[[ -f "$backupfile" ]] && zenity --info --timeout="5" --title="Saved" --text="Repositories backup saved successfully."
	fi
fi
}
