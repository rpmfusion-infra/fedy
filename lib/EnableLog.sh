function EnableLog()
{
# Enable logging
if [ "$KEEPLOG" = "YES" ]; then
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
	echo $(cat /etc/issue) | tee -a "$LOGFILE"
	echo $(uname -irs) | tee -a "$LOGFILE"
	echo "" | tee -a "$LOGFILE"
	echo "[Variables]" | tee -a "$LOGFILE"
	echo "" | tee -a "$LOGFILE"
	echo "Script directory is $SCRIPTDIR" | tee -a "$LOGFILE"
	echo "Library directory is $LIBDIR" | tee -a "$LOGFILE"
	echo "Modules directory is $MODULES" | tee -a "$LOGFILE"
	echo "Plugins directory is $PLUGINS" | tee -a "$LOGFILE"
	echo "Home directory is $HOMEDIR" | tee -a "$LOGFILE"
	echo "Work directory is $WORKINGDIR" | tee -a "$LOGFILE"
	echo "Keep backup? $KEEPBACKUP" | tee -a "$LOGFILE"
	echo "Keep downloads? $KEEPDOWNLOADS" | tee -a "$LOGFILE"
	echo "Downloads directory is $DOWNLOADSDIR" | tee -a "$LOGFILE"
	echo "Force downloads? $FORCE" | tee -a "$LOGFILE"
	echo "Logfile is "$LOGFILE"" | tee -a "$LOGFILE"
	echo "" >> "$LOGFILE"
	echo "[Outputs]" >> "$LOGFILE"
	echo "" >> "$LOGFILE"
	exec &>> "$LOGFILE"
fi
}
