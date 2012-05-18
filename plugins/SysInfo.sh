function M_F_SysInfo # Show system info
{
SysInfo
}

function SysInfo()
{
cat <<EOF | tee sysinfo.txt
Distribution: $(cat /etc/system-release)
Kernel: $(uname -s -r)
Architecture: $(uname -i)
RAM: $(cat /proc/meminfo | grep MemTotal | cut -c10-)
Graphics: $(lspci -s 00:02.0)
EOF
zenity --text-info --title="System information" --filename="sysinfo.txt" --ok-label="Ok" --cancel-label="Back"
Misc
}

