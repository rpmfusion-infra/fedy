enable_log() {
# Enable logging
if [[ "$keeplog" = "yes" ]]; then
	show_msg "Logging is enabled\n"
	# Unset Colors
	unset BOLD RED REDBOLD GREEN GREENBOLD YELLOW YELLOWBOLD BLUE BLUEBOLD ENDCOLOR
	# Rotate old logfile
	[[ -f "$logfile" ]] && mv "$logfile" "$logfile-$(stat -c %Y ${logfile})"
	# Create logfile
	touch "$logfile"
	echo -e "[$(date)]\n" >> "$logfile"
	echo -e "$program - $version" >> "$logfile"
	echo -e "$(cat /etc/system-release)" >> "$logfile"
	echo -e "$(uname -irs)" >> "$logfile"
	if [[ -f "$userconf" ]]; then
		echo -e "\n[User config]\n" >> "$logfile"
		cat "$userconf" >> "$logfile"
	fi
	if [[ -f "$sysconf" ]]; then
		echo -e "\n[Global config]\n" >> "$logfile"
		cat "$sysconf" >> "$logfile"
	fi
	echo -e "\n[Variables]\n" >> "$logfile"
	log_vars=( "homedir" "scriptdir" "libdir" "moduledir" "plugindir" "supportdir" "workingdir" "sysconf" "userconf" "lockfile" "logfile" "downagent" "prefwget" "forcedown" "forcedistro" "keepbackup" "keepdownloads" "downloadsdir" "tts" )
	for log_var in "${log_vars[@]}"; do
		echo -e "$log_var=${!log_var}" >> $logfile
	done
	echo -e "\n[Libraries]\n" >> "$logfile"
	echo -e "$(ls $libdir)" >> "$logfile"
	echo -e "\n[Modules]\n" >> "$logfile"
	echo -e "$(ls $moduledir)" >> "$logfile"
	echo -e "\n[Plugins]\n" >> "$logfile"
	echo -e "$(ls $plugindir)" >> "$logfile"
	echo -e "\n[Support]\n" >> "$logfile"
	echo -e "$(ls $supportdir)" >> "$logfile"
	echo -e "\n[Outputs]\n" >> "$logfile"
	exec &>> "$logfile"
	tail -f -n +1 "$logfile" >/dev/tty &
fi
}
