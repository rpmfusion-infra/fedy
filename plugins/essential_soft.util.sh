# Name: Install essential software
# Command: essential_soft
# Value: True

essential_soft() {
show_func "Installing essential software"
if [[ "$(essential_soft_test)" = "Installed" ]]; then
	show_status "Essential software already installed"
else
	install_pkg cabextract dconf-editor p7zip p7zip-plugins wget xz-lzma-compat unrar yum-plugin-fastestmirror
fi
[[ "$(essential_soft_test)" = "Installed" ]]; exit_state
}

essential_soft_test() {
if [[ -f /usr/bin/cabextract && -f /usr/bin/dconf-editor && -f /usr/bin/7za && -f /usr/bin/7z && -f /usr/bin/wget && -f /usr/bin/lzma && -f /usr/bin/unrar && -f /usr/lib/yum-plugins/fastestmirror.py ]]; then
	printf "Installed"
else
	printf "Not installed"
fi
}
