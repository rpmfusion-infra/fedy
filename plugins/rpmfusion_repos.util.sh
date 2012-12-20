# Name: Add RPM Fusion repositories
# Command: rpmfusion_repos
# Value: True

rpmfusion_repos() {
show_func "Adding RPM Fusion repos"
add_repo "rpmfusion-free.repo" "rpmfusion-nonfree.repo"
[[ "$(rpmfusion_repos_test)" = "Added" ]]; exit_state
}

rpmfusion_repos_test() {
if [[ -f /etc/yum.repos.d/rpmfusion-free.repo && -f /etc/yum.repos.d/rpmfusion-nonfree.repo ]]; then
	printf "Added"
else
	printf "Not added"
fi
}
