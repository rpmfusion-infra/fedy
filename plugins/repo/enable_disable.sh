# Name: Enable/disable repositories
# Command: enable_disable

enable_disable() {
build_repolist "/etc/yum.repos.d/"
while repos=$(zenity --list --checklist --width=900 --height=600 --title="System repositories" --text="The following repositories are present on your system. Check a repo to enable, uncheck to disable, then click apply." --hide-header --column "Select" --column "Name" --column "Description" --column "Status" --ok-label="Apply" --cancel-label="Back" "${repolist[@]}"); do
	selrepo=$(echo $repos | tr "|" "\n")
	show_func "Applying changes"
	sed -i 's/enabled=.*$/enabled=0/g' /etc/yum.repos.d/*.repo
	for repofile in $selrepo; do
		sed -i 's/enabled=.*$/enabled=1/g' /etc/yum.repos.d/$repofile
	done
	build_repolist "/etc/yum.repos.d/"
	exit_state
done
}
