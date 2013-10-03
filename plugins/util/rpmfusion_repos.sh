# Name: Configure RPM Fusion repositories
# Command: rpmfusion_repos

rpmfusion_repos() {
show_func "Configuring RPM Fusion repositories"
add_repo "rpmfusion-free.repo" "rpmfusion-nonfree.repo"
[[ "$(rpmfusion_repos_test)" = "Configured" ]]; exit_state
}

rpmfusion_repos_test() {
check_repo "rpmfusion-free.repo" && check_repo "rpmfusion-nonfree.repo"
if [[ $? -eq 0 ]]; then
    printf "Configured"
else
    printf "Not configured"
fi
}
