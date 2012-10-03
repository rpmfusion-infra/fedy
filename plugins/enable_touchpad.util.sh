# Name: Enable systemwide touchpad tap
# Command: enable_touchpad
# Value: True

enable_touchpad() {
show_func "Enabling systemwide touchpad tap"
if [[ -f /etc/X11/xorg.conf.d/00-enable-taps.conf ]]; then
	show_status "Touchpad tap already enabled"
else
cat <<EOF | tee /etc/X11/xorg.conf.d/00-enable-taps.conf
Section "InputClass"
       Identifier "tap-by-default"
       MatchIsTouchpad "on"
       Option "TapButton1" "1"
EndSection
EOF
fi
show_msg "Enabling touchpad tap for current user"
sudo -u "$user" gsettings set org.gnome.settings-daemon.peripherals.touchpad tap-to-click true
[[ -f /etc/X11/xorg.conf.d/00-enable-taps.conf ]]; exit_state
}
