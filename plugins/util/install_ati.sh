# Name: Install ATI video driver
# Command: install_ati

install_ati() {
show_func "Installing ATI video driver"
if [[ "$(install_ati_test)" = "Installed" && ! "$reinstall" = "yes" ]]; then
    show_status "ATI video driver seems to be already installed"
else
    add_repo "rpmfusion-free.repo" "rpmfusion-nonfree.repo"
    show_msg "Updating required packages"
    yum -y update kernel kernel-PAE selinux-policy
    show_msg "Installing drivers"
    install_pkg akmod-catalyst xorg-x11-drv-catalyst xorg-x11-drv-catalyst-libs.i686 && new-kernel-pkg --kernel-args=nomodeset --mkinitrd --dracut --update $(rpm -q --queryformat="%{version}-%{release}.%{arch}\n" kernel | tail -n 1) && aticonfig --initial -f
fi
[[ "$(install_ati_test)" = "Installed" ]]; exit_state
}

install_ati_test() {
if [[ -f /usr/bin/aticonfig ]]; then
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
