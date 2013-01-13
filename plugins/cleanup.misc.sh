# Name: Clean up system
# Command: cleanup
# Value: False

cleanup() {
while clean=$(zenity --list --checklist --width=350 --height=400 --title="Clean up system" --text="Clean up your system to free up space.\nThese options affect all users. Use at your own risk." --hide-header --hide-column=2 --column "Select" --column "Command" --column "Option" FALSE "kernel" "Remove old kernels" FALSE "duplicate" "Remove duplicate packages" FALSE "junk" "Delete junk files" FALSE "backup" "Delete backup files" FALSE "bash" "Erase bash history" FALSE "trash" "Empty trash" FALSE "logfile" "Delete Fedora Utils logs" --hide-header --ok-label="Select" --cancel-label="Back"); do
	arr=$(echo $clean | tr "|" "\n")
	for x in $arr; do
		case $x in
		"kernel")
			zenity --question --title="Remove all old kernels?" --text="Keeping old kernels might be helpful in case you face any problem with the current kernel. If you proceed, $program will invoke the <b><i>package-cleanup</i></b> command to remove all old kernels except the current running kernel. Do you want to proceed?" --ok-label "Yes" --cancel-label "No"
			if [[ $? -eq 0 ]]; then
				show_msg "Removing old kernels..."
				package-cleanup -y --oldkernels --count=1
			fi;;
		"duplicate")
			show_msg "Removing duplicate packages..."
			package-cleanup -y --cleandupes;;
		"junk")
			show_msg "Deleting desktop.ini..."
			find /home/ -name 'desktop.ini' -delete
			show_msg "Deleting Thumbs.db..."
			find /home/ -name 'Thumbs.db' -delete
			show_msg "Deleting .DS_Store..."
			find /home/ -name '.DS_Store' -delete;;
		"backup")
			show_msg "Deleting backup files..."
			find /home/ -name '*~' -delete
			find /home/ -name '*.bak' -delete
			find /home/ -name '*.BAK' -delete;;
		"bash")
			show_msg "Erasing bash history..."
			rm -f /home/*/.bash_history
			rm -f /root/*/.bash_history;;
		"trash")
			show_msg "Emptying trash..."
			rm -rf /home/*/.local/share/Trash/*
			rm -rf /root/.local/share/Trash/*;;
		"logfile")
			show_msg "Deleting Fedora Utils log files..."
			rm -f "$logfile" "$logfile"-*;;
		esac
	done
	exit_state
done
}
