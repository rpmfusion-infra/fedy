# Name: Install Numix GTK and icon themes
# Command: numix_themes

numixlist=( "numix-gtk-theme" "numix-icon-theme" "numix-icon-theme-circle" )

numix_themes() {
show_func "Installing Numix GTK and icon themes"
if [[ "$(numix_themes_test)" = "Installed" ]]; then
    show_status "Numix GTK and icon themes already installed"
else
    install_pkg gtk-murrine-engine
    add_repo "numix.repo"
    install_pkg_prevrel "numix.repo" ${numixlist[@]}
fi
[[ "$(numix_themes_test)" = "Installed" ]]; exit_state
}

numix_themes_undo() {
show_func "Uninstalling Numix GTK and icon themes"
erase_pkg ${numixlist[@]}
remove_repo "numix.repo"
[[ ! "$(numix_themes_test)" = "Installed" ]]; exit_state
}

numix_themes_test() {
query_pkg ${numixlist[@]}
if [[ $? -eq 0 ]]; then
    printf "Installed"
else
    printf "Not installed"
fi
}
