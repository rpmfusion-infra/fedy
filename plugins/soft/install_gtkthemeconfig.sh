# Name: Install Theme Configuration app
# Command: install_gtkthemeconfig

install_gtkthemeconfig() {
show_func "Installing Theme Configuration app"
if [[ "$(install_gtkthemeconfig_test)" = "Installed" && ! "$reinstall" = "yes" ]]; then
    show_status "Theme Configuration app already installed"
else
    add_repo "gtk-theme-config.repo"
    install_pkg gtk-theme-config
fi
[[ "$(install_gtkthemeconfig_test)" = "Installed" ]]; exit_state
}

install_gtkthemeconfig_test() {
if [[ -f /usr/bin/gtk-theme-config ]]; then
    printf "Installed"
else
    printf "Not installed"
fi
}
