# Name: Install Dropbox
# Command: install_dropbox

install_dropbox() {
show_func "Installing Dropbox"
if [[ "$(install_dropbox_test)" = "Installed" ]]; then
	show_status "Dropbox already installed"
else
	get32="https://linux.dropbox.com/packages/fedora/nautilus-dropbox-1.6.0-1.fedora.i386.rpm"
	file32="nautilus-dropbox-1.6.0-1.fedora.i386.rpm"
	get64="https://linux.dropbox.com/packages/fedora/nautilus-dropbox-1.6.0-1.fedora.x86_64.rpm"
	file64="nautilus-dropbox-1.6.0-1.fedora.x86_64.rpm"
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
