# Name: Install tidy-cache plugin for yum
# Command: install_tidycache
# Value: True

install_tidycache() {
show_func "Installing tidy-cache plugin for yum"
if [[ -f /usr/lib/yum-plugins/tidy-cache.py ]]; then
	show_status "tidy-cache plugin for yum is already installed"
else
	file="tidy-cache-LATEST.tar.gz"
	get="http://www.hyperdrifter.com/software/files/tidy-cache-LATEST.tar.gz"
	get_file
	tar xzf "$file"
	cp tidy-cache/tidy-cache.py /usr/lib/yum-plugins/
	cp tidy-cache/tidy-cache.conf /etc/yum/pluginconf.d/
fi
[[ -f /usr/lib/yum-plugins/tidy-cache.py ]]; exit_state
}
