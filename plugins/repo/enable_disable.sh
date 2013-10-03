# Name: Enable/disable repositories
# Command: enable_disable

enable_disable() {
while :
do
    build_repolist "/etc/yum.repos.d/"
    repos=$(dialog_show --list --checklist --width=900 --height=600 --title="System repositories" --text="The following repositories are present on your system. Check a repo to enable, uncheck to disable, then click apply." --no-headers --print-column="2" --column "Select:CHK" --column "Name" --column "Description" --column "Status" --button="Back:1" --button="Apply:0" "${repolist[@]}")
    if [[ $? -eq 0 ]]; then
	    selrepo=$(echo $repos | tr "|" "\n")
	    show_func "Applying changes"
	    for repofile in /etc/yum.repos.d/*; do
		    if [[ `grep "enabled=.*$" "$repofile"` ]]; then
			    sed -i 's/enabled=.*$/enabled=0/g' "$repofile"
		    else
			    echo "enabled=0" >> "$repofile"
		    fi
	    done
	    for repofile in $selrepo; do
		    sed -i 's/enabled=.*$/enabled=1/g' "/etc/yum.repos.d/$repofile"
	    done
	    exit_state
	else
	    break
	fi
done
}
