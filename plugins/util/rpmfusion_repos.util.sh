# Name: Add RPM Fusion repositories
# Command: rpmfusion_repos

rpmfusion_repos() {
show_func "Adding RPM Fusion repos"
add_repo "rpmfusion-free.repo" "rpmfusion-nonfree.repo"
[[ "$(rpmfusion_repos_test)" = "Added" ]]; exit_state
}

rpmfusion_repos_test() {
yum repolist all 2>&1 | cut -d\  -f1 | cut -d/ -f1 | grep -w "rpmfusion-free" > /dev/null 2>&1 && yum repolist all 2>&1 | cut -d\  -f1 | cut -d/ -f1 | grep -w "rpmfusion-nonfree" > /dev/null 2>&1
if [[ $? -eq 0 ]]; then
	printf "Added"
else
	printf "Not added"
fi
}
