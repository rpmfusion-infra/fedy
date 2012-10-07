# Name: Install Wine with Gecko
# Command: install_wine
# Value: False

install_wine() {
show_func "Installing Wine"
if [[ "$(install_wine_test)" = "Installed with gecko" || "$(install_wine_test)" = "Installed" ]]; then
	show_status "Wine already installed"
else
	add_repo "rpmfusion-free.repo" "rpmfusion-nonfree.repo"
	install_pkg wine
fi
	show_func "Installing Wine Gecko"
if [[ "$(install_wine_test)" = "Installed with gecko" ]]; then
	show_status "Wine Gecko already installed"
else
	if [[ "$arch" = "32" ]]; then
		get="http://downloads.sourceforge.net/wine/wine_gecko-1.7-x86.msi"
		file="wine_gecko-1.7-x86.msi"
		get_file
		mkdir -p /usr/share/wine/gecko
		cp "$file" /usr/share/wine/gecko/
	elif [[ "$arch" = "64" ]]; then
		get="http://downloads.sourceforge.net/wine/wine_gecko-1.7-x86_64.msi"
		file="wine_gecko-1.7-x86_64.msi"
		get_file
		mkdir -p /usr/share/wine/gecko
		cp "$file" /usr/share/wine/gecko/
	fi
fi
[[ "$(install_wine_test)" = "Installed with gecko" ]]; exit_state
}

install_wine_test() {
if [[ -f /usr/lib/wine/libwine.so && -d /usr/share/wine/gecko ]]; then
	printf "Installed with gecko"
elif [[ -f /usr/lib/wine/libwine.so ]]; then
	printf "Installed"
else
	printf "Not installed"
fi
}
