# Name: Enable USB modems
# Command: enable_modem
# Value: True

enable_modem() {
show_func "Enabling USB modems"
if [[ "$(enable_modem_test)" = "Enabled" ]]; then
	show_status "USB modems already enabled"
else
cat <<EOF | tee /etc/modprobe.d/usb-modem.conf
usbserial
option
EOF
fi
[[ "$(enable_modem_test)" = "Enabled" ]]; exit_state
}

enable_modem_test() {
if [[ -f /etc/modprobe.d/usb-modem.conf ]]; then
	printf "Enabled"
else
	printf "Not enabled"
fi
}
