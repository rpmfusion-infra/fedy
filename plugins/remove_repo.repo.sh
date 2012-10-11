# Name: Remove repositories
# Command: list_repos
# Value: False

remove_repo() {
show_msg "Removing $repofile"
rm -f /etc/yum.repos.d/$repofile
[[ ! -f /etc/yum.repos.d/$repofile ]]; exit_state
}

list_repos() {
build_repolist
while repos=$(zenity --list --checklist --width=850 --height=600 --title="Fedora People repositories" --text="The following repositories are present on your system." --column "Select" --column "Name" --column "Description" --ok-label="Remove selected" --cancel-label="Back" "${repolist[@]}"); do
	selrepo=$(echo $repos | tr "|" "\n")
	for repofile in $selrepo; do
		remove_repo
		build_repolist
	done
done
}

build_repolist() {
unset repolist
repofiles=($(ls /etc/yum.repos.d/))
for repofile in ${repofiles[@]}; do
	repodesc=$(grep "name=" "/etc/yum.repos.d/$repofile" | head -n 1 | sed -e 's/^name=//g')
	repolist=( "${repolist[@]}" FALSE "$repofile" "$repodesc" )
done
}
