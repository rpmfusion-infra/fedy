# Name: Disable system services
# Command: disable_services
# Value: FALSE

disable_services() {
while services=$(zenity --list --checklist --width=700 --height=600 --title="$program - Disable system services (Advanced)" --text="Disabling system services will decrease boot time, but may create problems and break your system.\nThe services along with their functions are listed below. Though the default selection should suit most desktops,\nplease carefully review and select only the services you don't need." --hide-header --column "Select" --column "Daemon" --column "Function" \
TRUE "abrt-ccpp" "Install ABRT coredump hook" \
TRUE "abrt-vmcore" "Harvest vmcores for ABRT" \
FALSE "abrtd" "ABRT Automated Bug Reporting tool" \
FALSE "auditd" "Security Auditing Service" \
FALSE "avahi-daemon" "Avahi mDNS/DNS-SD Stack" \
FALSE "bluetooth" "Bluetooth Manager" \
FALSE "cpuspeed" "Set the CPU Speed according to the system load" \
FALSE "cups" "CUPS Printing Service" \
TRUE "fcoe" "Fibre channel over ethernet devices" \
TRUE "firstboot" "Perform certain tasks once upon booting after installation" \
FALSE "fedora-storage-init-late" "Initialize storage subsystems (RAID, LVM, etc.)" \
FALSE "fedora-storage-init" "Initialize storage subsystems (RAID, LVM, etc.)" \
FALSE "fedora-wait-storage" "Wait for storage scan" \
FALSE "ip6tables" "IPv6 firewall with ip6tables" \
FALSE "iptables" "IPv4 firewall with iptables" \
TRUE "irda" "Infrared Manager" \
TRUE "iscsi" "Manage iSCSI devices" \
TRUE "iscsid" "Implement the control path of iSCSI protocol" \
TRUE "livesys-late" "Late init script for live image." \
TRUE "livesys" "Init script for live image." \
TRUE "lldpad" "Execute the LLDP protocol" \
FALSE "lvm2-monitor" "Monitoring of LVM2 mirrors, snapshots etc." \
FALSE "mcelog" "Machine Check Exception Logging Daemon" \
TRUE "mdmonitor" "Software RAID monitoring and management" \
FALSE "mysqld" "Start the MySQL Service" \
FALSE "netconsole" "Initialize network console logging" \
FALSE "netfs" "Connect to another server or filesharing on your local network" \
FALSE "ntpd" "Start the Network Time Protocol" \
TRUE "ntpdate" "Synchronize date with a NTP Server" \
TRUE "pppoe-server" "User-space server for Point-to-Point Protocol over Ethernet" \
TRUE "psacct" "Monitor several utilities" \
TRUE "rsyslog" "System Logging Service" \
TRUE "saslauthd" "Handle SASL plaintext authentication requests in servers using SASL" \
TRUE "sendmail" "Sendmail Mail Transport Agent" \
TRUE "sm-client" "Sendmail Mail Transport Client" \
TRUE "smolt" "Gather & Send info about your system to Fedora devs on a monthly basis" \
FALSE "spice-vdagentd" "Agent daemon for Spice guests" \
--ok-label="Disable" --cancel-label="Back"); do
	show_msg "Optimizing boot process..."
	arr=$(echo $services | tr "|" "\n")
	for x in $arr
	do
		case $x in
		"abrt-ccpp") systemctl disable abrt-ccpp.service;;
		"abrt-vmcore") systemctl disable abrt-vmcore.service;;
		"abrtd") systemctl disable abrtd.service;;
		"auditd") systemctl disable auditd.service;;
		"avahi-daemon") systemctl disable avahi-daemon.service;;
		"bluetooth") systemctl disable bluetooth.service;;
		"cpuspeed") systemctl disable cpuspeed.service;;
		"cups") systemctl disable cups.service;;
		"fcoe") systemctl disable fcoe.service;;
		"firstboot") systemctl disable firstboot.service;;
		"fedora-storage-init-late") systemctl disable fedora-storage-init-late.service;;
		"fedora-storage-init") systemctl disable fedora-storage-init.service;;
		"fedora-wait-storage") systemctl disable fedora-wait-storage.service;;
		"ip6tables") systemctl disable ip6tables.service;;
		"iptables") systemctl disable iptables.service;;
		"irda") systemctl disable irda.service;;
		"iscsi") systemctl disable iscsi.service;;
		"iscsid") systemctl disable iscsid.service;;
		"livesys-late") systemctl disable livesys-late.service;;
		"livesys") systemctl disable livesys.service;;
		"lldpad") systemctl disable lldpad.service;;
		"lvm2-monitor") systemctl disable lvm2-monitor.service;;
		"mcelog") systemctl disable mcelog.service;;
		"mdmonitor") systemctl disable mdmonitor.service;;
		"mysqld") systemctl disable mysqld.service;;
		"netconsole") systemctl disable netconsole.service;;
		"netfs") systemctl disable netfs.service;;
		"ntpd") systemctl disable ntpd.service;;
		"ntpdate") systemctl disable ntpdate.service;;
		"pppoe-server") systemctl disable pppoe-server.service;;
		"psacct") systemctl disable psacct.service;;
		"rsyslog") systemctl disable rsyslog.service;;
		"saslauthd") systemctl disable saslauthd.service;;
		"sendmail") systemctl disable sendmail.service;;
		"sm-client") systemctl disable sm-client.service;;
		"smolt") systemctl disable smolt.service;;
		"spice-vdagentd") systemctl disable spice-vdagentd.service;;
		esac
	done
	exit_state
done
}
