function U_F_EnableModem # Enable USB modems
{
EnableModem
}

function EnableModem()
{
ShowFunc "Enabling USB modems"
if [ -f /etc/modprobe.d/usb-modem.conf ]; then
StatusMsg "USB modems already enabled"
else
cat <<EOF | tee /etc/modprobe.d/usb-modem.conf
usbserial
option
EOF
fi
if [ -f /etc/modprobe.d/usb-modem.conf ]; then
Success
else
Failure
fi
}
