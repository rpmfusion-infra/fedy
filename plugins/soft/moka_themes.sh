# Name: Install Moka themes
# Command: moka_themes

mokalist=( "moka-gnome-shell-theme" "moka-icon-theme" "faba-icon-theme" "faba-mono-icons" )

moka_themes() {
show_func "Installing Moka themes"
if [[ "$(moka_themes_test)" = "Installed" ]]; then
    show_status "Moka themes already installed"
else
    add_repo "moka-project.repo"
    install_pkg_prevrel "moka-project.repo" ${mokalist[@]}

fi
[[ "$(moka_themes_test)" = "Installed" ]]; exit_state
}

moka_themes_undo() {
show_func "Uninstalling Moka themes"
erase_pkg ${mokalist[@]}
remove_repo "moka-project.repo"
[[ ! "$(moka_themes_test)" = "Installed" ]]; exit_state
}

moka_themes_test() {
query_pkg ${mokalist[@]}
if [[ $? -eq 0 ]]; then
    printf "Installed"
else
    printf "Not installed"
fi
}
