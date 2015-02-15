# Name: Install Jetbrains RubyMine
# Command: jetbrains_rubymine
 
jetbrains_rubymine() {
show_func "Installing Jetbrains RubyMine"
if [[ "$(jetbrains_rubymine_test)" = "Installed" ]]; then
	show_status "Jetbrains RubyMine already installed"
else
	show_msg "Getting latest version"
	get_file_quiet "https://www.jetbrains.com/ruby/download/download_thanks.jsp?os=linux" "rubymine.html"
	get=$(cat rubymine.html | grep -o "https://download.jetbrains.com/ruby/RubyMine-[0-9.]*.tar.gz" | head -n 1)
	file=${get##*/}
	get_file

	if [[ -f "$file" ]]; then
		show_msg "Installing files"
		rm -rf "/opt/jetbrains-rubymine"
		tar -xzf "$file" -C "/opt"
		mv /opt/RubyMine* "/opt/jetbrains-rubymine"
		ln -sf "/opt/jetbrains-rubymine/bin/rubymine.sh" "/usr/bin/rubymine"
		cp -f "/opt/jetbrains-rubymine/bin/rubymine.png" "/usr/share/icons/hicolor/32x32/apps/jetbrains-rubymine.png"
		gtk-update-icon-cache -f -t /usr/share/icons/hicolor > /dev/null 2>&1

cat <<EOF | tee /usr/share/applications/jetbrains-rubymine.desktop > /dev/null 2>&1
[Desktop Entry]
Name=Jetbrains RubyMine
Icon=jetbrains-rubymine
Comment=The Most Intelligent Ruby and Rails IDE
Exec=rubymine
Terminal=false
Type=Application
StartupNotify=true
Categories=IDE;Development;
Keywords=Jetbrains;Ruby;Rails;IDE;
EOF
	fi
fi
[[ "$(jetbrains_rubymine_test)" = "Installed" ]]; exit_state
}
 
jetbrains_rubymine_undo() {
show_func "Uninstalling Jetbrains RubyMine"
rm -f "/usr/share/applications/jetbrains-rubymine.desktop"
rm -f "/usr/bin/rubymine"
rm -f "/usr/share/icons/hicolor/32x32/apps/rubymine.png"
rm -rf "/opt/jetbrains-rubymine"
[[ ! "$(jetbrains_rubymine_test)" = "Installed" ]]; exit_state
}

jetbrains_rubymine_test() {
if [[ -f /opt/jetbrains-rubymine/bin/rubymine.sh ]]; then
printf "Installed"
else
printf "Not installed"
fi
} 
