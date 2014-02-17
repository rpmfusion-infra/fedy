# Name: Install Moka themes
# Command: moka_themes

mokalist=( "moka-gtk-theme" "moka-icon-theme" )

moka_themes() {
show_func "Installing Moka themes"
if [[ "$(moka_themes_test)" = "Installed" ]]; then
    show_status "Moka themes already installed"
else
    add_repo "moka-icon-theme.repo"
    add_repo "moka-gtk-theme.repo"
    install_pkg_prevrel "moka-icon-theme.repo" moka-icon-theme
    install_pkg_prevrel "moka-gtk-theme.repo" moka-gtk-theme

fi
[[ "$(moka_themes_test)" = "Installed" ]]; exit_state
}

moka_themes_undo() {
show_func "Uninstalling Moka themes"
erase_pkg ${mokalist[@]}
remove_repo "moka-icon-theme.repo"
remove_repo "moka-gtk-theme.repo"
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
