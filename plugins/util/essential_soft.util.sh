# Name: Install essential software
# Command: essential_soft

essential_soft() {
show_func "Installing essential software"
if [[ "$(essential_soft_test)" = "Installed" ]]; then
	show_status "Essential software already installed"
else
	install_pkg cabextract cups-pdf dconf-editor nano p7zip p7zip-plugins unrar wget xz-lzma-compat yum-plugin-fastestmirror
fi
[[ "$(essential_soft_test)" = "Installed" ]]; exit_state
}

essential_soft_test() {
ls /usr/bin/cabextract > /dev/null 2>&1 && ls /usr/lib/cups/backend/cups-pdf > /dev/null 2>&1 && ls /usr/bin/dconf-editor > /dev/null 2>&1 && ls /usr/bin/nano > /dev/null 2>&1 && ls /usr/bin/7za > /dev/null 2>&1 && ls /usr/bin/7z > /dev/null 2>&1 && ls /usr/bin/unrar > /dev/null 2>&1 && ls /usr/bin/wget > /dev/null 2>&1 && ls /usr/bin/lzma > /dev/null 2>&1 && ls /usr/lib*/yum-plugins/fastestmirror.py > /dev/null 2>&1
if [[ $? -eq 0 ]]; then
	printf "Installed"
else
	printf "Not installed"
fi
}
