# Name: Install Jockey driver installer
# Command: install_jockey
# Value: True

install_jockey() {
show_func "Installing Jockey driver installer"
if [[ "$(install_jockey_test)" = "Installed" ]]; then
	show_status "Jockey Driver Installer already installed"
else
	add_repo "rpmfusion-free.repo" "rpmfusion-nonfree.repo" "parsidora.repo"
	if [[ "$(pidof ksmserver)" ]]; then
		yum -y --enablerepo=parsidora install jockey-selinux jockey-kde
	else
		yum -y --enablerepo=parsidora install jockey-selinux jockey-gtk
	fi
fi
[[ "$(install_jockey_test)" = "Installed" ]]; exit_state
}

install_jockey_test() {
if [[ -f /usr/bin/jockey-gtk || -f /usr/bin/jockey-kde ]]; then
	printf "Installed"
else
	printf "Not installed"
fi
}
