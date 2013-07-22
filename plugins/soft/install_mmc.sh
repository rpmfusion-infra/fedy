# Name: Install Mobile Media Converter
# Command: install_mmc

install_mmc() {
show_func "Installing Mobile Media Converter"
if [[ "$(install_mmc_test)" = "Installed" && ! "$reinstall" = "yes" ]]; then
	show_status "Mobile Media Converter already installed"
else
	add_repo "rpmfusion-free.repo" "rpmfusion-nonfree.repo"
	show_msg "Installing dependencies"
	install_pkg cairo expat ffmpeg gdk-pixbuf2 glib2 glibc gtk2 libstdc++ libX11 libXext libXi mencoder pango python
	show_msg "Fetching webpage"
	get_file_quiet "http://www.miksoft.net/products/mmc-older/" "mmc.htm"
	file=$(grep -o "mmc-lin-[0-9]*.tar.gz" "mmc.htm" | tail -n 1)
	get="http://www.miksoft.net/products/mmc-older/$file"
	get_file
	gunzip "$file"
	tar -xvf "${file%.gz}"
	mkdir -p "/opt/MobileMediaConverter"
	cp -rf "lib" "/opt/MobileMediaConverter/"
	ln -sf "/opt/MobileMediaConverter/lib/mmc" "/usr/bin/mmc"
show_msg "Creating desktop file"
cat <<EOF | tee /usr/share/applications/mmc.desktop > /dev/null 2>&1
[Desktop Entry]
Name=Mobile Media Converter
GenericName=Multimedia Converter
Icon=applications-multimedia
Comment=Convert between popular audio and video formats
Exec=/opt/MobileMediaConverter/lib/mmc %F
MimeType=x-content/video-dvd;x-content/video-vcd;x-content/video-svcd;
Terminal=false
Type=Application
StartupNotify=true
Categories=AudioVideo;AudioVideoEditing;
EOF
fi
[[ "$(install_mmc_test)" = "Installed" ]]; exit_state
}

install_mmc_test() {
if [[ -f /opt/MobileMediaConverter/lib/mmc ]]; then
	printf "Installed"
else
	printf "Not installed"
fi
}
