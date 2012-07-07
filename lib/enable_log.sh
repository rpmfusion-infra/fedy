enable_log() {
# Enable logging
if [ "$keeplog" = "yes" ]; then
	show_msg "Logging is enabled"
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
	if [ -e "$logfile" ]; then
		mv "$logfile" ""$logfile"-$(date +"%Y%m%d%H%M%S")"
	fi
	# Create logfile
	touch "$logfile"
	echo "[$(date)]" >> "$logfile"
	echo "" >> "$logfile"
	echo "$program - $version" >> "$logfile"
	cat /etc/system-release >> "$logfile"
	echo $(uname -irs) >> "$logfile"
	echo "" >> "$logfile"
	if [ -f "$userconf" ]; then
	echo "[User config]" >> "$logfile"
	echo "" >> "$logfile"
	cat "$userconf" >> "$logfile" 
	echo "" >> "$logfile"
	fi
	if [ -f "$sysconf" ]; then
	echo "[Global config]" >> "$logfile"
	echo "" >> "$logfile"
	cat "$sysconf" >> "$logfile" 
	echo "" >> "$logfile"
	fi
	echo "[Variables]" >> "$logfile"
	echo "" >> "$logfile"
	echo "Home directory: $homedir" >> "$logfile"
	echo "Script directory: $scriptdir" >> "$logfile"
	echo "Library directory: $libdir" >> "$logfile"
	echo "Modules directory: $moduledir" >> "$logfile"
	echo "Plugins directory: $plugindir" >> "$logfile"
	echo "Work directory: $workingdir" >> "$logfile"
	echo "Global config: $sysconf" >> "$logfile"
	echo "User config: $userconf" >> "$logfile"
	echo "Lock file: $lockfile" >> "$logfile"
	echo "Log file: $logfile" >> "$logfile"
	echo "Download agent: $downagent" >> "$logfile"
	echo "Prefer wget: $prefwget" >> "$logfile"
	echo "Force redownload: $forcedown" >> "$logfile"
	echo "Force distro: $forcedistro" >> "$logfile"	
	echo "Backup configs: $keepbackup" >> "$logfile"
	echo "Save downloads: $keepdownloads" >> "$logfile"
	echo "Downloads directory: $downloadsdir" >> "$logfile"
	echo "Use TTS: $tts" >> "$logfile"
	echo "" >> "$logfile"
	echo "[Libraries]" >> "$logfile"
	echo "" >> "$logfile"
	echo "$(ls $libdir)" >> "$logfile"
	echo "" >> "$logfile"
	echo "[Modules]" >> "$logfile"
	echo "" >> "$logfile"
	echo "$(ls $moduledir)" >> "$logfile"
	echo "" >> "$logfile"
	echo "[Plugins]" >> "$logfile"
	echo "" >> "$logfile"
	echo "$(ls $plugindir)" >> "$logfile"
	echo "" >> "$logfile"
	echo "[Outputs]" >> "$logfile"
	echo "" >> "$logfile"
	exec &>> "$logfile"
	tail -f -n +1 "$logfile" >/dev/tty &
fi
}
