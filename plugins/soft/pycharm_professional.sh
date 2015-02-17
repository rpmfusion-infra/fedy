# Name: Install Jetbrains PyCharm Professional
# Command: pycharm_professional
 
pycharm_professional() {
show_func "Installing Jetbrains PyCharm Professional"
if [[ "$(pycharm_professional_test)" = "Installed" ]]; then
	show_status "Jetbrains PyCharm Professional already installed"
else
	show_msg "Getting latest version"
	get_file_quiet "https://www.jetbrains.com/pycharm/download/download_thanks.jsp?os=linux" "pycharm-p.html"
	get="$(cat pycharm-p.html | grep -o https://download.jetbrains.com/python/pycharm-professional-[0-9.]*.tar.gz | head -n 1)"
	file=${get##*/}
	get_file
	if [[ -f "$file" ]]; then
		show_msg "Installing files"
		rm -rf "/opt/pycharm-professional"
		tar -xzf "$file" -C "/opt"
		mv /opt/pycharm* "/opt/pycharm-professional"
		ln -sf "/opt/pycharm-professional/bin/pycharm.sh" "/usr/bin/pycharm-professional"
		cp -f "/opt/pycharm-professional/bin/pycharm.png" "/usr/share/icons/hicolor/128x128/apps/jetbrains-pycharm.png"
		gtk-update-icon-cache -f -t /usr/share/icons/hicolor > /dev/null 2>&1
 
cat <<EOF | tee /usr/share/applications/pycharm-professional.desktop > /dev/null 2>&1
[Desktop Entry]
Name=Jetbrains PyCharm Professional
Icon=jetbrains-pycharm
Comment=The Most Intelligent Python IDE
Exec=pycharm-professional
Terminal=false
Type=Application
StartupNotify=true
Categories=IDE;Development;
Keywords=Jetbrains;Python;Django;Flask;IDE;
EOF
	fi
fi
[[ "$(pycharm_professional_test)" = "Installed" ]]; exit_state
}
 
pycharm_professional_undo() {
show_msg "Uninstalling Jetbrains PyCharm Professional"
rm -f "/usr/bin/pycharm-professional"
rm -f "/usr/share/icons/hicolor/128x128/apps/jetbrains-pycharm.png"
rm -rf "/opt/pycharm-professional"
[[ ! "$(pycharm_professional_test)" = "Installed" ]]; exit_state
}
 
pycharm_professional_test() {
if [[ -f "/opt/pycharm-professional/bin/pycharm.sh" ]]; then
	echo "Installed"
else
	echo "Not Installed"
fi
} 
