# Name: Show system info
# Command: sys_info
# Value: False

sys_info() {
cat <<EOF | tee sysinfo.txt
Distribution: $(cat /etc/issue | head -n 1)
Kernel: $(uname -irs)
RAM: $(grep MemTotal /proc/meminfo | cut -c18-)
Video: $(lspci | grep VGA | cut -c36-)
Audio: $(lspci | grep Audio | cut -c23-)
Ethernet: $(lspci | grep Ethernet | cut -c30-)
Wireless: $(lspci | grep Network | cut -c29-)
EOF
[[ "$interactive" = "no" ]] ||zenity --text-info --title="System information" --filename="sysinfo.txt" --ok-label="Ok" --cancel-label="Back"
rm -f sysinfo.txt
}
