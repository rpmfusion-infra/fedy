# Name: Install Jockey driver installer
# Command: install_jockey
# Value: True

install_jockey() {
show_func "Installing Jockey driver installer"
if [[ -e /usr/bin/jockey-gtk || -e /usr/bin/jockey-kde ]]; then
show_status "Jockey Driver Installer already installed"
else
	add_repo "rpmfusion-free.repo"
	add_repo "rpmfusion-nonfree.repo"
	add_repo "parsidora.repo"
	if [[ "$(pidof ksmserver)" ]]; then
		yum -y --enablerepo=parsidora install jockey-selinux jockey-kde
	else
		yum -y --enablerepo=parsidora install jockey-selinux jockey-gtk
	fi
fi
[[ -e /usr/bin/jockey-gtk || -e /usr/bin/jockey-kde ]]; exit_state
}
