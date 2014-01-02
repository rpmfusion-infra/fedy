# Name: Install Numix GTK and icon themes
# Command: numix_themes

numix_themes() {
show_func "Installing Numix GTK and icon themes"
if [[ "$(numix_themes_test)" = "Installed" && ! "$reinstall" = "yes" ]]; then
    show_status "Numix GTK and icon themes already installed"
else
    install_pkg gtk-murrine-engine
    add_repo "numix.repo"
    install_pkg_prevrel "numix.repo" numix-gtk-theme numix-icon-theme numix-icon-theme-circle
fi
[[ "$(numix_themes_test)" = "Installed" ]]; exit_state
}

numix_themes_undo() {
show_func "Uninstalling Numix GTK and icon themes"
erase_pkg numix-gtk-theme numix-icon-theme numix-icon-theme-circle
remove_repo "numix.repo"
[[ ! "$(numix_themes_test)" = "Installed" ]]; exit_state
}

numix_themes_test() {
if [[ -d /usr/share/themes/Numix && -d /usr/share/icons/Numix && -d /usr/share/icons/Numix-Circle ]]; then
    printf "Installed"
else
    printf "Not installed"
fi
}
