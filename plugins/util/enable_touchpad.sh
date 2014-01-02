# Name: Enable systemwide touchpad tap
# Command: enable_touchpad

enable_touchpad() {
show_func "Enabling systemwide touchpad tap"
if [[ "$(enable_touchpad_test)" = "Enabled" && ! "$reinstall" = "yes" ]]; then
    show_status "Touchpad tap already enabled"
else
cat <<EOF | tee /etc/X11/xorg.conf.d/00-enable-taps.conf > /dev/null 2>&1
Section "InputClass"
       Identifier "tap-by-default"
       MatchIsTouchpad "on"
       Option "TapButton1" "1"
EndSection
EOF
fi
show_msg "Enabling touchpad tap for current user"
sudo -u "$user" dbus-launch gsettings set org.gnome.settings-daemon.peripherals.touchpad tap-to-click true
[[ "$(enable_touchpad_test)" = "Enabled" ]]; exit_state
}

enable_touchpad_undo() {
show_func "Removing systemwide touchpad tap"
rm -f /etc/X11/xorg.conf.d/00-enable-taps.conf > /dev/null 2>&1
[[ ! "$(enable_touchpad_test)" = "Enabled" ]]; exit_state
}

enable_touchpad_test() {
if [[ -f /etc/X11/xorg.conf.d/00-enable-taps.conf ]]; then
    printf "Enabled"
else
    printf "Not enabled"
fi
}
