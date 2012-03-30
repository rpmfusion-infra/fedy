function M_F_CleanUp # Clean up system
{
CleanUp
}

function CleanUp()
{
clean=$(zenity --list --width=350 --height=400 --title="Clean up system" --text="Clean up your system and free up space.\nThese options affect all users.\nUse at your own risk." --checklist  --column "Select" --column "Options" FALSE "Delete Backup Files" FALSE "Delete Empty Folders" FALSE "Remove Old Kernels" FALSE "Remove Duplicate Packages" FALSE "Erase Bash History" FALSE "Empty Trash" FALSE "Delete Fedora Utils Logs" --hide-header --ok-label="Select" --cancel-label="Back")
arr=$(echo $clean | tr "\:" "\n")
for x in $arr
do
	case $x in
	"Backup") ShowMsg "Deleting Backup Files..."
			find /home/ -name '*~' -delete
			find /home/ -name '*.bak' -delete;;
	"Empty") ShowMsg "Deleting Empty Folders..."
			find /home/ -type d -empty -delete;;
	"Kernels") ShowMsg "Removing Old Kernel..."
			package-cleanup --oldkernels --count=1
			REBOOTREQUIRED="YES";;
	"Duplicate") ShowMsg "Removing Duplicate Packages..."
			package-cleanup --cleandupes;;
	"Bash History") ShowMsg "Erasing Bash History..."
			rm -f /home/*/.bash_history
			rm -f /root/*/.bash_history;;
	"Trash") ShowMsg "Emptying Trash..."
			rm -rf /home/*/.local/share/Trash/*
			rm -rf /root/.local/share/Trash/*;;
	"Utils") ShowMsg "Deleting Fedora Utils Log Files..."
			rm -f "$LOGFILE" "$LOGFILE"-*;;
	esac
done
if [ $? = "0" ]; then
Success
else
Failure
fi
Misc
}
