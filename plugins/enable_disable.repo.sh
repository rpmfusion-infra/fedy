# Name: Enable/disable repositories
# Command: enable_disable
# Value: False

enable_disable() {
build_repostates
while repos=$(zenity --list --checklist --width=900 --height=600 --title="System repositories" --text="The following repositories are present on your system. Check a repo to enable, uncheck to disable, then click apply." --hide-header --column "Select" --column "Name" --column "Description" --column "Status" --ok-label="Apply" --cancel-label="Back" "${repolist[@]}"); do
	selrepo=$(echo $repos | tr "|" "\n")
	sed -i 's/enabled=1/enabled=0/g' /etc/yum.repos.d/*.repo
	for repofile in $selrepo; do
		sed -i 's/enabled=0/enabled=1/g' /etc/yum.repos.d/$repofile
		build_repostates
	done
done
}

build_repostates() {
unset repolist
repofiles=($(ls /etc/yum.repos.d/))
for repofile in ${repofiles[@]}; do
	if [[ `grep "enabled=1" "/etc/yum.repos.d/$repofile"` ]]; then
		repostat="Enabled"
		check="TRUE"
	else
		repostat="Disabled"
		check="FALSE"
	fi
	repodesc=$(grep "name=" "/etc/yum.repos.d/$repofile" | head -n 1 | sed -e 's/^name=//g' -e s/\$releasever/$fver/g -e s/\$basearch/$(uname -i)/g)
	repolist=( "${repolist[@]}" "$check" "$repofile" "$repodesc" "$repostat" )
done
}
