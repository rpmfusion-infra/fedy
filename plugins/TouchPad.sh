function U_T_TouchPad # Enable systemwide touchpad tap
{
TouchPad
}

function TouchPad()
{
ShowFunc "Enabling systemwide touchpad tap"
if [ -f /etc/X11/xorg.conf.d/00-enable-taps.conf ]; then
StatusMsg "Touchpad tap already enabled"
else
cat <<EOF | tee /etc/X11/xorg.conf.d/00-enable-taps.conf
Section "InputClass"
       Identifier "tap-by-default"
       MatchIsTouchpad "on"
       Option "TapButton1" "1"
EndSection
EOF
StatusMsg "Touchpad tap already enabled"
fi
ShowMsg "Enabling touchpad tap for current user"
sudo -u "$USER" gsettings set org.gnome.settings-daemon.peripherals.touchpad tap-to-click true
if [ -f /etc/X11/xorg.conf.d/00-enable-taps.conf ]; then
Success
else
Failure
fi
}
