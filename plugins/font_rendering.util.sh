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
if [[ `cat "$homedir/.Xresources" | grep "Xft.lcdfilter: lcddefault"` && -d /usr/lib/freetype-freeworld ]]; then
	printf "Improved"
else
	printf "Not improved"
fi
}
