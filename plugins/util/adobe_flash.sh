# Name: Install Adobe flash plugin
# Command: adobe_flash

adobe_flash() {
show_func "Installing Adobe flash plugin"
if [[ "$(adobe_flash_test)" = "Installed" && ! "$reinstall" = "yes" ]]; then
    show_status "Adobe flash plugin already installed"
else
    if [[ "$arch" = "32" ]]; then
        add_repo "adobe-linux-i386.repo"
    elif [[ "$arch" = "64" ]]; then
        add_repo "adobe-linux-x86_64.repo"
    fi
    install_pkg flash-plugin
fi
[[ "$(adobe_flash_test)" = "Installed" ]]; exit_state
}

adobe_flash_undo() {
show_func "Uninstalling Adobe flash plugin"
erase_pkg adobe-release flash-plugin
if [[ "$arch" = "32" ]]; then
    remove_repo "adobe-linux-i386.repo"
elif [[ "$arch" = "64" ]]; then
    remove_repo "adobe-linux-x86_64.repo"
fi
[[ ! "$(adobe_flash_test)" = "Installed" ]]; exit_state
}

adobe_flash_test() {
query_pkg flash-plugin
if [[ $? -eq 0 ]]; then
    printf "Installed"
else
    printf "Not installed"
fi
}
