# Name: Enable USB modems
# Command: enable_modem
# Value: True

enable_modem() {
show_func "Enabling USB modems"
if [ -f /etc/modprobe.d/usb-modem.conf ]; then
show_status "USB modems already enabled"
else
cat <<EOF | tee /etc/modprobe.d/usb-modem.conf
usbserial
option
EOF
fi
[ -f /etc/modprobe.d/usb-modem.conf ]; exit_state
}
