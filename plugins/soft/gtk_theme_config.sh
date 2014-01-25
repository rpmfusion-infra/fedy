# Name: Install Theme Configuration app
# Command: gtk_theme_config

gtk_theme_config() {
show_func "Installing Theme Configuration app"
if [[ "$(gtk_theme_config_test)" = "Installed" && ! "$reinstall" = "yes" ]]; then
    show_status "Theme Configuration app already installed"
else
    install_pkg gsettings-desktop-schemas
    add_repo "gtk-theme-config.repo"
    install_pkg_prevrel "gtk-theme-config.repo" gtk-theme-config
fi
[[ "$(gtk_theme_config_test)" = "Installed" ]]; exit_state
}

gtk_theme_config_undo() {
show_func "Uninstalling Theme Configuration app"
erase_pkg gtk-theme-config
remove_repo "gtk-theme-config.repo"
[[ ! "$(gtk_theme_config_test)" = "Installed" ]]; exit_state
}

gtk_theme_config_test() {
query_pkg gtk-theme-config
if [[ $? -eq 0 ]]; then
    printf "Installed"
else
    printf "Not installed"
fi
}
