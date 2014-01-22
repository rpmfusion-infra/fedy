# Name: Install Dropbox
# Command: nautilus_dropbox

nautilus_dropbox() {
show_func "Installing Dropbox"
if [[ "$(nautilus_dropbox_test)" = "Installed" && ! "$reinstall" = "yes" ]]; then
    show_status "Dropbox already installed"
else
    show_msg "Getting latest version"
    get_file_quiet "https://www.dropbox.com/install?os=lnx" "dropbox.htm"
    file32=$(grep -o "nautilus-dropbox-[0-9].[0-9].[0-9]-[0-9].fedora.i386.rpm" "dropbox.htm" | head -n 1)
    get32="https://linux.dropbox.com/packages/fedora/${file32}"
    file64=$(grep -o "nautilus-dropbox-[0-9].[0-9].[0-9]-[0-9].fedora.x86_64.rpm" "dropbox.htm" | head -n 1)
    get64="https://linux.dropbox.com/packages/fedora/${file64}"
    process_pkg
    add_repo "dropbox.repo"
fi
[[ "$(nautilus_dropbox_test)" = "Installed" ]]; exit_state
}

nautilus_dropbox_undo() {
show_func "Uninstalling Dropbox"
erase_pkg nautilus-dropbox
remove_repo "dropbox.repo"
[[ ! "$(nautilus_dropbox_test)" = "Installed" ]]; exit_state
}

nautilus_dropbox_test() {
if [[ -f /usr/bin/dropbox ]]; then
    printf "Installed"
else
    printf "Not installed"
fi
}
