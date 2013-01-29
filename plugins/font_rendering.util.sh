# Name: Improve font rendering
# Command: font_rendering
# Value: True

font_rendering() {
show_func "Improving font rendering"
if [[ "$(font_rendering_test)" = "Improved" ]]; then
	show_status "Font rendering already improved"
else
	install_pkg freetype-freeworld
	echo "Xft.lcdfilter: lcddefault" > "$homedir/.Xresources"
fi
show_msg "Changing font settings for current user"
sudo -u "$user" gsettings set org.gnome.settings-daemon.plugins.xsettings antialiasing rgba
sudo -u "$user" gsettings set org.gnome.settings-daemon.plugins.xsettings hinting slight
[[ "$(font_rendering_test)" = "Improved" ]]; exit_state
}

font_rendering_test() {
ls /usr/lib*/freetype-freeworld > /dev/null 2>&1 && grep -s "Xft.lcdfilter: lcddefault" "$homedir/.Xresources" > /dev/null 2>&1
if [[ $? -eq 0 ]]; then
	printf "Improved"
else
	printf "Not improved"
fi
}
