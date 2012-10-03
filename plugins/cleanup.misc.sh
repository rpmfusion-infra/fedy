# Name: Clean up system
# Command: cleanup
# Value: False

cleanup() {
while clean=$(zenity --list --checklist --width=350 --height=400 --title="Clean up system" --text="Clean up your system and free up space.\nThese options affect all users. Use at your own risk." --hide-header --hide-column=2 --column "Select" --column "Command" --column "Option" FALSE "backup" "Delete Backup Files" FALSE "kernel" "Remove Old Kernels" FALSE "duplicate" "Remove Duplicate Packages" FALSE "history" "Erase Bash History" FALSE "trash" "Empty Trash" FALSE "logfile" "Delete Fedora Utils Logs" --hide-header --ok-label="Select" --cancel-label="Back"); do
	arr=$(echo $clean | tr "|" "\n")
	for x in $arr
	do
		case $x in
		"backup")
			show_msg "Deleting Backup Files..."
			find /home/ -name '*~' -delete
			find /home/ -name '*.bak' -delete;;
		"kernel")
			show_msg "Removing Old Kernel..."
			package-cleanup --oldkernels --count=1;;
		"duplicate")
			show_msg "Removing Duplicate Packages..."
			package-cleanup --cleandupes;;
		"history")
			show_msg "Erasing Bash History..."
			rm -f /home/*/.bash_history
			rm -f /root/*/.bash_history;;
		"trash")
			show_msg "Emptying Trash..."
			rm -rf /home/*/.local/share/Trash/*
			rm -rf /root/.local/share/Trash/*;;
		"logfile")
			show_msg "Deleting Fedora Utils Log Files..."
			rm -f "$logfile" "$logfile"-*;;
		esac
	done
	exit_state
done
}
