# Name: Install Oracle Java
# Command: install_jre
# Value: False

install_jre() {
show_func "Installing Oracle JRE"
if [[ "$(install_jre_test)" = "Installed" ]]; then
	show_status "Oracle JRE already installed"
else
	file32="jre-7u7-linux-i586.rpm"
	get32="http://download.oracle.com/otn-pub/java/jdk/7u7-b10/jre-7u7-linux-i586.rpm"
	file64="jre-7u7-linux-x64.rpm"
	get64="http://download.oracle.com/otn-pub/java/jdk/7u7-b10/jre-7u7-linux-x64.rpm"
	process_pkg --header "Cookie: gpw_e24=www.oracle.com"
	show_msg "Setting up Oracle Java..."
	alternatives --install /usr/bin/java java /usr/java/default/bin/java 20000
	show_msg "Setting up Java plugin for firefox..."
	if [[ "$arch" = "32" ]]; then
		alternatives --install /usr/lib/mozilla/plugins/libjavaplugin.so libjavaplugin.so /usr/java/default/lib/i386/libnpjp2.so 20000
	elif [[ "$arch" = "64" ]]; then
		alternatives --install /usr/lib64/mozilla/plugins/libjavaplugin.so libjavaplugin.so.x86_64 /usr/java/default/lib/amd64/libnpjp2.so 20000
	fi
fi
[[ "$(install_jre_test)" = "Installed" ]]; exit_state
}

install_jre_test() {
if [[ -f /usr/java/jdk1.7.0_*/bin/java ]]; then
	printf "Installed"
else
	printf "Not installed"
fi
}
