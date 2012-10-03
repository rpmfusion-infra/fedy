# Name: Add additional repositories
# Command: add_repos
# Value: True

add_repos() {
show_func "Adding additional repos"
add_repo "rpmfusion-free.repo" "rpmfusion-nonfree.repo" "google.repo" "fedora-chromium-stable.repo" "skype.repo" "adobe-linux.repo"
}
