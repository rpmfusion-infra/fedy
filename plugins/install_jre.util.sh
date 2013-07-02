# Name: Install Oracle Java
# Command: install_jre
# Value: False

install_jre() {
show_func "Installing Oracle JRE"
if [[ "$(install_jre_test)" = "Installed" ]]; then
	show_status "Oracle JRE already installed"
else
	show_msg "Fetching webpage..."
	get_file_quiet "http://www.oracle.com/technetwork/java/javase/downloads/index.html" "index.html"
	dlurl=$(cat index.html | tr ' ' '\n' | grep "/technetwork/java/javase/downloads/jre7" | head -n 1 | cut -d\" -f 2 | sed -e 's/^/http:\/\/www.oracle.com/')
	get_file_quiet "$dlurl" "download.html"
	get32=$(grep "Linux x86" "download.html" | grep ".rpm" | cut -d\" -f 12 | grep -v demos | head -n 1)
	file32=${get32##*/}
	get64=$(grep "Linux x64" "download.html" | grep ".rpm" | cut -d\" -f 12 | grep -v demos | head -n 1)
	file64=${get64##*/}
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
ls /usr/java/jre* > /dev/null 2>&1
if [[ $? -eq 0 ]]; then
	printf "Installed"
else
	printf "Not installed"
fi
}
