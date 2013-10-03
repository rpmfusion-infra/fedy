# Name: Show system info
# Command: sys_info

sys_info() {
cat <<EOF | tee sysinfo.txt > /dev/null 2>&1
Distribution: $(cat /etc/issue | head -n 1)
Kernel: $(uname -irs)
RAM: $(grep MemTotal /proc/meminfo | cut -c18-)
Video: $(lspci | grep VGA | cut -c36-)
Audio: $(lspci | grep Audio | cut -c23-)
Ethernet: $(lspci | grep Ethernet | cut -c30-)
Wireless: $(lspci | grep Network | cut -c29-)
EOF
[[ "$interactive" = "no" ]] || dialog_show --text-info --width=400 --height=400 --title="System information" --filename="sysinfo.txt" --button="Back:0"
rm -f sysinfo.txt
}
