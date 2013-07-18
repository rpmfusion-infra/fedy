# Name: Install Dropbox
# Command: install_dropbox

install_dropbox() {
show_func "Installing Dropbox"
if [[ "$(install_dropbox_test)" = "Installed" && ! "$reinstall" = "yes" ]]; then
	show_status "Dropbox already installed"
else
	show_msg "Fetching webpage"
	get_file_quiet "https://www.dropbox.com/install?os=lnx" "install.htm"
	file32=$(grep -o "nautilus-dropbox-[0-9].[0-9].[0-9]-[0-9].fedora.i386.rpm" "install.htm" | head -n 1)
	get32="https://linux.dropbox.com/packages/fedora/${file32}"
	file64=$(grep -o "nautilus-dropbox-[0-9].[0-9].[0-9]-[0-9].fedora.x86_64.rpm" "install.htm" | head -n 1)
	get64="https://linux.dropbox.com/packages/fedora/${file64}"
	process_pkg
fi
[[ "$(install_dropbox_test)" = "Installed" ]]; exit_state
}

install_dropbox_test() {
if [[ -f /usr/bin/dropbox ]]; then
	printf "Installed"
else
	printf "Not installed"
fi
}
