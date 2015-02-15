# Name: Install Jetbrains WebStorm
# Command: jetbrains_webstorm
 
jetbrains_webstorm() {
show_func "Installing Jetbrains WebStorm"
if [[ "$(jetbrains_webstorm_test)" = "Installed" ]]; then
	show_status "Jetbrains WebStorm already installed"
else
	show_msg "Getting latest version"
	get_file_quiet "https://www.jetbrains.com/webstorm/download/download_thanks.jsp?os=linux" "webstorm.html"
	get=$(cat webstorm.html | grep -o "https://download.jetbrains.com/webstorm/WebStorm-[0-9.]*.tar.gz" | head -n 1)
	file=${get##*/}
	get_file

	if [[ -f "$file" ]]; then
		show_msg "Installing files"
		rm -rf "/opt/jetbrains-webstorm"
		tar -xzf "$file" -C "/opt"
		mv /opt/WebStorm* "/opt/jetbrains-webstorm"
		ln -sf "/opt/jetbrains-webstorm/bin/webstorm.sh" "/usr/bin/webstorm"
		cp -f "/opt/jetbrains-webstorm/bin/webide.png" "/usr/share/icons/hicolor/128x128/apps/jetbrains-webstorm.png"
		gtk-update-icon-cache -f -t /usr/share/icons/hicolor > /dev/null 2>&1

cat <<EOF | tee /usr/share/applications/jetbrains-webstorm.desktop > /dev/null 2>&1
[Desktop Entry]
Name=Jetbrains WebStorm
Icon=jetbrains-webstorm
Comment=The Smartest JavaScript IDE
Exec=webstorm
Terminal=false
Type=Application
StartupNotify=true
Categories=IDE;Development;
Keywords=Jetbrains;HTML;JavaScript;CSS;IDE;
EOF
	fi
fi
[[ "$(jetbrains_webstorm_test)" = "Installed" ]]; exit_state
}
 
jetbrains_webstorm_undo() {
show_func "Uninstalling Jetbrains WebStorm"
rm -f "/usr/share/applications/jetbrains-webstorm.desktop"
rm -f "/usr/bin/webstorm"
rm -f "/usr/share/icons/hicolor/128x128/apps/webstorm.png"
rm -rf "/opt/jetbrains-webstorm"
[[ ! "$(jetbrains_webstorm_test)" = "Installed" ]]; exit_state
}

jetbrains_webstorm_test() {
if [[ -f /opt/jetbrains-webstorm/bin/webstorm.sh ]]; then
printf "Installed"
else
printf "Not installed"
fi
} 
