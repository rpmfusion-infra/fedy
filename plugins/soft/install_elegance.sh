# Name: Install Elegance Colors
# Command: install_elegance

install_elegance() {
show_func "Installing Elegance Colors Gnome Shell theme"
if [[ "$(install_elegance_test)" = "Installed" && ! "$reinstall" = "yes" ]]; then
    show_status "Elegance Colors Gnome Shell theme already installed"
else
    install_pkg bc gnome-shell ImageMagick
    add_repo "elegance-colors.repo"
    install_pkg_prevrel "elegance-colors.repo" gnome-shell-theme-elegance-colors
fi
[[ "$(install_elegance_test)" = "Installed" ]]; exit_state
}

install_elegance_remove() {
show_func "Removing Elegance Colors Gnome Shell theme"
erase_pkg gnome-shell-theme-elegance-colors
remove_repo "elegance-colors.repo"
[[ ! "$(install_elegance_test)" = "Installed" ]]; exit_state
}

install_elegance_test() {
if [[ -f /usr/bin/elegance-colors ]]; then
    printf "Installed"
else
    printf "Not installed"
fi
}
