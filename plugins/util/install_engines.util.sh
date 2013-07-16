# Name: Install GTK theme engines
# Command: install_engines

install_engines() {
show_func "Installing GTK theme engines"
if [[ "$(install_engines_test)" = "Installed" ]]; then
	show_status "GTK theme engines already installed"
else
	install_pkg gtk-murrine-engine gtk-unico-engine
fi
[[ "$(install_engines_test)" = "Installed" ]]; exit_state
}

install_engines_test() {
ls /usr/lib*/gtk-3.0/3.0.0/theming-engines/libunico.so > /dev/null 2>&1 && ls /usr/lib*/gtk-2.0/*/engines/libmurrine.so > /dev/null 2>&1
if [[ $? -eq 0 ]]; then
	printf "Installed"
else
	printf "Not installed"
fi
}
