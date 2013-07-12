# Name: Install Arista Transcoder
# Command: install_arista

install_arista() {
show_func "Installing Arista Transcoder"
if [[ "$(install_arista_test)" = "Installed" ]]; then
	show_status "Arista Transcoder already installed"
else
	add_repo "rpmfusion-free.repo" "rpmfusion-nonfree.repo"
	install_pkg gnome-python2-gconf python2-devel python3-devel python-gudev gstreamer-plugins-bad-nonfree
	show_msg "Fetching webpage..."
	get_file_quiet "https://github.com/danielgtaylor/arista/tags.atom" "tags.atom"
	aristaver=$(grep "<title>.*</title>" "tags.atom" | grep -o "[0-9].[0-9].[0-9]" | head -n 1)
	get="https://github.com/danielgtaylor/arista/archive/${aristaver}.tar.gz"
	file=${get##*/}
	get_file
	tar -xvf "$file"
	cd arista-*
	python setup.py build
	python setup.py install
fi
[[ "$(install_arista_test)" = "Installed" ]]; exit_state
}

install_arista_test() {
if [[ -f /usr/local/bin/arista-gtk ]]; then
	printf "Installed"
else
	printf "Not installed"
fi
}
