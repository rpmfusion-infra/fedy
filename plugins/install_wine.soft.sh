# Name: Install Wine with Gecko
# Command: install_wine
# Value: False

install_wine() {
show_func "Installing Wine"
if [[ -d /usr/lib/wine ]]; then
show_status "Wine already installed"
else
rpmfusionrepo
install_pkg wine
fi
show_func "Installing Wine Gecko"
if [[ -f /usr/share/wine/gecko/wine_gecko* ]]; then
show_status "Wine Gecko already installed"
else
	if [[ $(uname -i) = "i386" ]]; then
	file="wine_gecko-1.7-x86.msi"
	get="http://downloads.sourceforge.net/wine/wine_gecko-1.7-x86.msi"
	GetFile
	mkdir -p /usr/share/wine/gecko
	cp "$file" /usr/share/wine/gecko/
	elif [[ $(uname -i) = "x86_64" ]]; then
	file="wine_gecko-1.7-x86_64.msi"
	get="http://downloads.sourceforge.net/wine/wine_gecko-1.7-x86_64.msi"
	GetFile
	mkdir -p /usr/share/wine/gecko
	cp "$file" /usr/share/wine/gecko/
	fi
fi
[[ -d /usr/lib/wine && -f /usr/share/wine/gecko/wine_gecko* ]]; exit_state
}
