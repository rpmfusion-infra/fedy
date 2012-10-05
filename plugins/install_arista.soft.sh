# Name: Install Arista Transcoder
# Command: install_arista
# Value: False

install_arista() {
show_func "Installing Arista Transcoder"
if [[ -e /usr/bin/arista-gtk ]]; then
	show_status "Arista Transcoder already installed"
else
	add_repo "rpmfusion-free.repo" "rpmfusion-nonfree.repo"
	install_pkg python2-devel python3-devel python-gudev gstreamer-plugins-bad-nonfree
	file="arista-0.9.7.tar.gz"
	get="http://programmer-art.org/media/releases/arista-transcoder/arista-0.9.7.tar.gz"
	get_file
	tar -xvf "$file"
	cd arista-0.9.7
	python setup.py build
	python setup.py install
fi
[[ -e /usr/bin/arista-gtk ]]; exit_state
}
