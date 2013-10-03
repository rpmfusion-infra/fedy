# Name: Delete repositories
# Command: delete_repos

delete_repos() {
while :
do
    build_repolist "/etc/yum.repos.d/" "false"
    repos=$(dialog_show --list --checklist --width=900 --height=600 --title="Select repositories to delete" --text="Deleting a repo will delete the repo from the system. It does not affect installed packages." --no-headers --print-column="2" --column "Select:CHK" --column "Name" --column "Description" --column "Status" --button="Back:1" --button="Delete selected:0" "${repolist[@]}")
    if [[ $? -eq 0 ]]; then
	    selrepo=$(echo $repos | tr "|" "\n")
	    for repofile in $selrepo; do
		    show_msg "Deleting $repofile"
		    rm -f /etc/yum.repos.d/$repofile
		    [[ ! -f /etc/yum.repos.d/$repofile ]]; exit_state
	    done
	else
	    break
	fi
done
}
