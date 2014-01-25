# Name: Install Dropbox
# Command: nautilus_dropbox

nautilus_dropbox() {
show_func "Installing Dropbox"
if [[ "$(nautilus_dropbox_test)" = "Installed" ]]; then
    show_status "Dropbox already installed"
else
    show_msg "Getting latest version"
    get_file_quiet "https://www.dropbox.com/install?os=lnx" "dropbox.htm"
    get32=$(cat "dropbox.htm" | tr ' ' '\n' | grep -o "nautilus-dropbox-[0-9].[0-9].[0-9]-[0-9].fedora.i386.rpm" | head -n 1 | sed -e 's/^/http:\/\/linux.dropbox.com\/packages\/fedora\//')
    file32=${get32##*/}
    get64=$(cat "dropbox.htm" | tr ' ' '\n' | grep -o "nautilus-dropbox-[0-9].[0-9].[0-9]-[0-9].fedora.x86_64.rpm" | head -n 1 | sed -e 's/^/http:\/\/linux.dropbox.com\/packages\/fedora\//')
    file64=${get64##*/}
    echo $get64
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
query_pkg nautilus-dropbox
if [[ $? -eq 0 ]]; then
    printf "Installed"
else
    printf "Not installed"
fi
}
