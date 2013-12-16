# Name: Install Numix GTK and icon themes
# Command: install_numix

install_numix() {
show_func "Installing Numix GTK and icon themes"
if [[ "$(install_numix_test)" = "Installed" && ! "$reinstall" = "yes" ]]; then
    show_status "Numix GTK and icon themes already installed"
else
    add_repo "numix.repo"
    install_pkg_prevrel "numix.repo" numix-gtk-theme numix-icon-theme numix-icon-theme-circle
fi
[[ "$(install_numix_test)" = "Installed" ]]; exit_state
}

install_numix_test() {
if [[ -d /usr/share/themes/Numix && -d /usr/share/icons/Numix && -d /usr/share/icons/Numix-Circle ]]; then
    printf "Installed"
else
    printf "Not installed"
fi
}
