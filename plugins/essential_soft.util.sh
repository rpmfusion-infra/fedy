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
if [[ `which cabextract` && `which dconf-editor` && `which 7za` && `which 7z` && `which wget` && `which lzma` && `which unrar` && -f /usr/lib/yum-plugins/fastestmirror.py ]]; then
	printf "Installed"
else
	printf "Not installed"
fi
}
