# Name: Improve font rendering
# Command: font_rendering
# Value: True

font_rendering() {
show_func "Improving font rendering"
if [[ -d /usr/share/doc/freetype-freeworld* ]]; then
	show_status "Freetype font rendering engine already installed"
else
	install_pkg freetype-freeworld
fi
sudo -u "$user" gsettings "set" "org.gnome.settings-daemon.plugins.xsettings" "antialiasing" "rgba"
sudo -u "$user" gsettings "set" "org.gnome.settings-daemon.plugins.xsettings" "hinting" "slight"
echo "Xft.lcdfilter: lcddefault" > "$homedir/.Xresources"
[[ `cat "$homedir/.Xresources" | grep "Xft.lcdfilter: lcddefault"` && -d /usr/share/doc/freetype-freeworld* ]]; exit_state
}
