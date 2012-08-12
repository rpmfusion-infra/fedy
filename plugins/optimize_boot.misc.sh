# Name: Optimize boot process
# Command: optimize_boot
# Value: False

optimize_boot() {
while daemons=$(zenity --list --checklist --width=750 --height=600 --title="$program - Disable Unnecessary Daemons" --text="Turning off system daemons will decrease boot time, but may create problems and break your system.\nThe daemons along with their functions are listed below. Though the default selection should suit most people,\nplease carefully review and select only the daemons you don't need." --hide-header --column "Select" --column "Daemon" --column "Function" FALSE "abrt" "Manages application crashes" FALSE "bluetooth" "Required for Bluetooth" FALSE "cpuspeed" "Sets the CPU Speed according to the system load" FALSE "cups" "Starts the Printing Service" FALSE "httpd" "Starts the Apache HTTP Server" TRUE "fcoe" "Required if you have fibre channel over ethernet devices" TRUE "firstboot" "Performs certain tasks once upon booting after installation" FALSE "iptables" "Recommended if you are directly connected to internet" TRUE "ip6tables" "Used in ipv6" TRUE "irda" "Required for Infrared" TRUE "iscsi" "Required if you have iSCSI devices" TRUE "iscsid" "Implements the control path of iSCSI protocol" TRUE "livesys" "Only needed for the Live CD" TRUE "livesys-late" "Only needed in the Live Session" TRUE "lldpad" "Executes the LLDP protocol" TRUE "mdmonitor" "Monitors Software RAID or LVM information" FALSE "mysqld" "Starts the MySQL Service" FALSE "netfs" "Useful if you connect to another server or filesharing on your local network" FALSE "netconsole" "Initializes network console logging" FALSE "ntpd" "Starts the Network Time Protocol" TRUE "ntpdate" "Synchronizes date with a NTP Server" TRUE "pppoe-server" "User-space server for Point-to-Point Protocol over Ethernet" TRUE "psacct" "Monitors several utilities" TRUE "rsyslog" "Handles logging in server environments" TRUE "saslauthd" "Handles SASL plaintext authentication requests in servers using SASL" TRUE "sendmail" "Starts the Sendmail Service" TRUE "smolt" "Gathers & Sends info about your system to Fedora devs on a monthly basis" FALSE "wpa_supplicant" "Required if you use a wireless card that requires WPA based encryption" --ok-label="Turn Off" --cancel-label="Back"); do
	show_msg "Optimizing boot process..."
	arr=$(echo $daemons | tr "|" "\n")
	for x in $arr
	do
		case $x in
		"abrtd") chkconfig abrtd off;;
		"bluetooth") chkconfig bluetooth off;;
		"cpuspeed") chkconfig cpuspeed off;;
		"cups") chkconfig cups off;;
		"httpd") chkconfig httpd off;;
		"fcoe") chkconfig fcoe off;;
		"firstboot") chkconfig firstboot off;;
		"iptables") chkconfig iptables off;;
		"ip6tables") chkconfig ip6tables off;;
		"irda") chkconfig irda off;;
		"iscsi") chkconfig iscsi off;;
		"iscsid") chkconfig iscsid off;;
		"livesys") chkconfig livesys off;;
		"livesys-late") chkconfig livesys-late off;;
		"lldpad") chkconfig lldpad off;;
		"mdmonitor") chkconfig mdmonitor off;;
		"mysqld") chkconfig mysqld off;;
		"netfs") chkconfig netfs off;;
		"netconsole") chkconfig netconsole off;;
		"ntpd") chkconfig ntpd off;;
		"ntpdate") chkconfig ntpdate off;;
		"pppoe-server") chkconfig pppoe-server off;;
		"psacct") chkconfig psacct off;;
		"rsyslog") chkconfig rsyslog off;;
		"saslauthd") chkconfig saslauthd off;;
		"sendmail") chkconfig sendmail off;;
		"smolt") chkconfig smolt off;;
		"wpa_supplicant") chkconfig wpa_supplicant off;;
		esac
	done
	exit_state
done
}
