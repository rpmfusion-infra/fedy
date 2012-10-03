# Name: Add additional repositories
# Command: add_repos
# Value: True

add_repos() {
show_func "Adding additional repos"
repolist=( "rpmfusion-free.repo" "rpmfusion-nonfree.repo" "google.repo" "fedora-chromium-stable.repo" "skype.repo" "adobe-linux.repo" )
for repofile in "${repolist[@]}"; do
	add_repo "$repofile"
	[[ -f /etc/yum.repos.d/$repofile ]]; exit_state
done
}
