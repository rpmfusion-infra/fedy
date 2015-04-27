# Name: Install Jetbrains PhpStorm
# Command: jetbrains_phpstorm
 
jetbrains_phpstorm() {
show_func "Installing Jetbrains PhpStorm"
if [[ "$(jetbrains_phpstorm_test)" = "Installed" ]]; then
	show_status "Jetbrains PhpStorm already installed"
else
	show_msg "Getting latest version"
	get_file_quiet "https://www.jetbrains.com/phpstorm/download/download_thanks.jsp?os=linux" "phpstorm.html"
	get=$(cat phpstorm.html | grep -o "https://download.jetbrains.com/webide/PhpStorm-[0-9.]*.tar.gz" | head -n 1)
	file=${get##*/}
	get_file

	if [[ -f "$file" ]]; then
		show_msg "Installing files"
		rm -rf "/opt/jetbrains-phpstorm"
		tar -xzf "$file" -C "/opt"
		mv /opt/PhpStorm* "/opt/jetbrains-phpstorm"
		ln -sf "/opt/jetbrains-phpstorm/bin/phpstorm.sh" "/usr/bin/phpstorm"
		cp -f "/opt/jetbrains-phpstorm/bin/webide.png" "/usr/share/icons/hicolor/256x256/apps/jetbrains-phpstorm.png"
		gtk-update-icon-cache -f -t /usr/share/icons/hicolor > /dev/null 2>&1

cat <<EOF | tee /usr/share/applications/jetbrains-phpstorm.desktop > /dev/null 2>&1
[Desktop Entry]
Name=Jetbrains PhpStorm
Icon=jetbrains-phpstorm
Comment=The Most Intelligent PHP IDE
Exec=phpstorm
Terminal=false
Type=Application
StartupNotify=true
Categories=IDE;Development;
Keywords=Jetbrains;PHP;IDE;
EOF
	fi
fi
[[ "$(jetbrains_phpstorm_test)" = "Installed" ]]; exit_state
}
 
jetbrains_phpstorm_undo() {
show_func "Uninstalling Jetbrains PhpStorm"
rm -f "/usr/share/applications/jetbrains-phpstorm.desktop"
rm -f "/usr/bin/phpstorm"
rm -f "/usr/share/icons/hicolor/256x256/apps/phpstorm.png"
rm -rf "/opt/jetbrains-phpstorm"
[[ ! "$(jetbrains_phpstorm_test)" = "Installed" ]]; exit_state
}

jetbrains_phpstorm_test() {
if [[ -f /opt/jetbrains-phpstorm/bin/phpstorm.sh ]]; then
printf "Installed"
else
printf "Not installed"
fi
} 
