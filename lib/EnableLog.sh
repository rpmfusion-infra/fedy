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
	echo "[$(date)]" >> "$LOGFILE"
	echo "" >> "$LOGFILE"
	echo "$PROGRAM - $VERSION" >> "$LOGFILE"
	cat /etc/system-release >> "$LOGFILE"
	echo $(uname -irs) >> "$LOGFILE"
	echo "" >> "$LOGFILE"
	if [ -f $USERCONF ]; then
	echo "[User config]" >> "$LOGFILE"
	echo "" >> "$LOGFILE"
	cat "$USERCONF" >> "$LOGFILE" 
	echo "" >> "$LOGFILE"
	fi
	if [ -f $SYSCONF ]; then
	echo "[Global config]" >> "$LOGFILE"
	echo "" >> "$LOGFILE"
	cat "$SYSCONF" >> "$LOGFILE" 
	echo "" >> "$LOGFILE"
	fi
	echo "[Variables]" >> "$LOGFILE"
	echo "" >> "$LOGFILE"
	echo "Home directory: $HOMEDIR" >> "$LOGFILE"
	echo "Script directory: $SCRIPTDIR" >> "$LOGFILE"
	echo "Library directory: $LIBS" >> "$LOGFILE"
	echo "Modules directory: $MODULES" >> "$LOGFILE"
	echo "Plugins directory: $PLUGINS" >> "$LOGFILE"
	echo "Work directory: $WORKINGDIR" >> "$LOGFILE"
	echo "Global config: $SYSCONF" >> "$LOGFILE"
	echo "User config: $USERCONF" >> "$LOGFILE"
	echo "Lock file: $LOCKFILE" >> "$LOGFILE"
	echo "Log file: $LOGFILE" >> "$LOGFILE"
	echo "Download agent: $DOWNAGENT" >> "$LOGFILE"
	echo "Prefer wget: $PREFWGET" >> "$LOGFILE"
	echo "Force redownload: $FORCEDOWN" >> "$LOGFILE"
	echo "Force distro: $FORCEDISTRO" >> "$LOGFILE"	
	echo "Backup configs: $KEEPBACKUP" >> "$LOGFILE"
	echo "Save downloads: $KEEPDOWNLOADS" >> "$LOGFILE"
	echo "Downloads directory: $DOWNLOADSDIR" >> "$LOGFILE"
	echo "Use TTS: $TTS" >> "$LOGFILE"
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
	tail -f -n +1 "$LOGFILE" >/dev/tty &
fi
}
