# Name: Install tidy-cache plugin for yum
# Command: install_tidycache
# Value: True

install_tidycache() {
show_func "Installing tidy-cache plugin for yum"
if [[ "$(install_tidycache_test)" = "Installed" ]]; then
	show_status "tidy-cache plugin for yum is already installed"
else
	file="tidy-cache-LATEST.tar.gz"
	get="http://www.hyperdrifter.com/software/files/tidy-cache-LATEST.tar.gz"
	get_file
	tar xzf "$file"
	cp tidy-cache/tidy-cache.py /usr/lib/yum-plugins/
	cp tidy-cache/tidy-cache.conf /etc/yum/pluginconf.d/
fi
[[ "$(install_tidycache_test)" = "Installed" ]]; exit_state
}

install_tidycache_test() {
if [[ -f /usr/lib/yum-plugins/tidy-cache.py ]]; then
	printf "Installed"
else
	printf "Not installed"
fi
}
