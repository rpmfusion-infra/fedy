# Name: Restore repositories from backup
# Command: restore_repos

restore_repos() {
unset repolist
backupfile=$(show_dialog --width=700 --height=600 --file-selection --file-filter="*.tgz" --title="Restore repositories from backup" --filename="$homedir/" --button="Cancel:1" --button="Restore:0")
if [[ $? -eq 0 ]]; then
    mkdir -p "repos"
    tar -xzf "$backupfile" --directory="repos"
    build_repolist "repos" "true"
    repos=$(show_dialog --list --checklist --width=900 --height=600 --title="Select repositories to restore" --no-headers --print-column="2" --column "Select:CHK" --column "Name" --column "Description" --column "Status" --button="Back:1" --button="Restore selected:0" "${repolist[@]}")
    if [[ $? -eq 0 ]]; then
        selrepo=$(echo $repos | tr "|" "\n")
        for repo in $selrepo; do
            show_msg "Restoring $repo"
            config_repo "repos/$repo"
        done
    fi
fi
}
