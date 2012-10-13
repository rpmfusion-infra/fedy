# Name: Remove repositories
# Command: list_repos
# Value: False

list_repos() {
build_repolist "/etc/yum.repos.d/" "false"
while repos=$(zenity --list --checklist --width=900 --height=600 --title="Remove repositories" --text="Removing a repo will delete the repo from the system. It does not affect installed packages." --hide-header --column "Select" --column "Name" --column "Description" --column "Status" --ok-label="Remove selected" --cancel-label="Back" "${repolist[@]}"); do
	selrepo=$(echo $repos | tr "|" "\n")
	for repofile in $selrepo; do
		show_msg "Removing $repofile"
		rm -f /etc/yum.repos.d/$repofile
		[[ ! -f /etc/yum.repos.d/$repofile ]]; exit_state
	done
	build_repolist "/etc/yum.repos.d/" "false"
done
}
