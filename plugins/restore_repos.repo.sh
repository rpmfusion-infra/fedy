# Name: Restore repositories from backup
# Command: restore_repos
# Value: False

restore_repos() {
unset repolist
backupfile=$(zenity --title="Select backup file to restore" --file-selection --file-filter="*.tgz")
mkdir -p "repos"
tar -xzf "$backupfile" --directory="repos"
build_repolist "repos" "true"
repos=$(zenity --list --checklist --width=900 --height=600 --title="Restore repositories" --text="Select repositories to restore." --hide-header --column "Select" --column "Name" --column "Description" --column "Status" --ok-label="Restore" --cancel-label="Cancel" "${repolist[@]}")
if [[ $? -eq 0 ]]; then
	selrepo=$(echo $repos | tr "|" "\n")
	for repo in $selrepo; do
		show_msg "Restoring $repo"
		mv -u repos/$repo /etc/yum.repos.d/
		exit_state
	done
fi
}
