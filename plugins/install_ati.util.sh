# Name: Install ATI driver
# Command: install_ati
# Value: False

install_ati() {
show_func "Installing ATI driver"
if [[ "$(install_ati_test)" = "Installed" ]]; then
	show_status "ATI driver seems to be already installed"
else
	install_pkg kernel-devel kernel-headers akmod-catalyst xorg-x11-drv-catalyst xorg-x11-drv-catalyst-libs.i686
fi
[[ "$(install_ati_test)" = "Installed" ]]; exit_state
}

install_ati_test() {
if [[ `rpm -qa *kmod-catalyst*` ]]; then
	printf "Installed"
else
	printf "Not installed"
fi
}

install_ati_hide() {
if [[ ! `lspci -nn | grep VGA | grep ATI` ]]; then
	printf "true"
fi
}
