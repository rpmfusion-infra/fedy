# Name: Configure RPM Fusion repositories
# Command: rpmfusion_repos

rpmfusion_repos() {
show_func "Configuring RPM Fusion repositories"
add_repo "rpmfusion-free.repo" "rpmfusion-nonfree.repo"
[[ "$(rpmfusion_repos_test)" = "Configured" ]]; exit_state
}

rpmfusion_repos_test() {
yum repolist all 2>&1 | cut -d\  -f1 | cut -d/ -f1 | grep -w "rpmfusion-free" > /dev/null 2>&1 && yum repolist all 2>&1 | cut -d\  -f1 | cut -d/ -f1 | grep -w "rpmfusion-nonfree" > /dev/null 2>&1
if [[ $? -eq 0 ]]; then
	printf "Configured"
else
	printf "Not configured"
fi
}
