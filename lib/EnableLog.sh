function EnableLog()
{
# Enable logging
if [ "$KEEPLOG" = "YES" ]; then
	ShowMsg "Logging is enabled"
	echo ""
	# Unset Colors
	unset BOLD
	unset RED
	unset REDBOLD
	unset GREEN
	unset GREENBOLD
	unset YELLOW
	unset YELLOWBOLD
	unset BLUE
	unset BLUEBOLD
	unset ENDCOLOR
	# Rotate old logfile
	if [ -e "$LOGFILE" ]; then
		mv "$LOGFILE" ""$LOGFILE"-$(date +"%Y%m%d%H%M%S")"
	fi
	# Create logfile
	touch "$LOGFILE"
	echo "[$(date)]" | tee -a "$LOGFILE"
	echo "" | tee -a "$LOGFILE"
	echo "$PROGRAM - $VERSION" | tee -a "$LOGFILE"
	echo $(cat /etc/system-release) | tee -a "$LOGFILE"
	echo $(uname -irs) | tee -a "$LOGFILE"
	echo "" | tee -a "$LOGFILE"
	echo "[Variables]" >> "$LOGFILE"
	echo "" >> "$LOGFILE"
	echo "Home directory: $HOMEDIR" >> "$LOGFILE"
	echo "Script directory: $SCRIPTDIR" >> "$LOGFILE"
	echo "Library directory: $LIBS" >> "$LOGFILE"
	echo "Modules directory: $MODULES" >> "$LOGFILE"
	echo "Plugins directory: $PLUGINS" >> "$LOGFILE"
	echo "Work directory: $WORKINGDIR" >> "$LOGFILE"
	echo "Lock file: $LOCKFILE" >> "$LOGFILE"
	echo "Log file: $LOGFILE" >> "$LOGFILE"
	echo "Force redownload: $FORCE" >> "$LOGFILE"
	echo "Force distro: $FORCEDISTRO" >> "$LOGFILE"	
	echo "Backup configs: $KEEPBACKUP" >> "$LOGFILE"
	echo "Save downloads: $KEEPDOWNLOADS" >> "$LOGFILE"
	echo "Downloads directory: $DOWNLOADSDIR" >> "$LOGFILE"
	echo "" >> "$LOGFILE"
	echo "[Libraries]" >> "$LOGFILE"
	echo "" >> "$LOGFILE"
	echo "$(ls $LIBS)" >> "$LOGFILE"
	echo "" >> "$LOGFILE"
	echo "[Modules]" >> "$LOGFILE"
	echo "" >> "$LOGFILE"
	echo "$(ls $MODULES)" >> "$LOGFILE"
	echo "" >> "$LOGFILE"
	echo "[Plugins]" >> "$LOGFILE"
	echo "" >> "$LOGFILE"
	echo "$(ls $PLUGINS)" >> "$LOGFILE"
	echo "" >> "$LOGFILE"
	echo "[Outputs]" >> "$LOGFILE"
	echo "" >> "$LOGFILE"
	exec &>> "$LOGFILE"
	tail -f -n +7 "$LOGFILE" >/dev/tty &
fi
}
