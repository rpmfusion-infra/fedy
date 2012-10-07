# Name: Add additional repositories
# Command: add_repos
# Value: True

add_repos() {
show_func "Adding additional repos"
add_repo "rpmfusion-free.repo" "rpmfusion-nonfree.repo" "google.repo" "skype.repo" "adobe-linux.repo"
[[ "$(add_repos_test)" = "Added" ]]; exit_state
}

add_repos_test() {
if [[ -f /etc/yum.repos.d/rpmfusion-free.repo && -f /etc/yum.repos.d/rpmfusion-nonfree.repo && -f /etc/yum.repos.d/google.repo && -f /etc/yum.repos.d/skype.repo && -f /etc/yum.repos.d/adobe-linux.repo ]]; then
	printf "Added"
else
	printf "Not added"
fi
}
