check_args() {
while [[ $# -gt 0 ]]; do
case "$1" in
	-l|--enable-log)
			keeplog="yes"
			shift;;
	-c|--pref-curl)
			prefwget="no"
			shift;;
	-w|--use-wget)
			downagent="wget"
			shift;;
	-r|--redownload)
			forcedown="yes"
			shift;;
	-f|--force-distro)
			forcedistro="yes"
			shift;;
	-n|--nobakup)
			keepbackup="no"
			shift;;
	-t|--use-tts)
			tts="yes"
			shift;;
	-d|--debug)
			if [[ -r "$logfile" ]]; then
				cat "$logfile"
			else
				echo -e "No logfile exists. Try running Fedora Utils with logging enabled. Use --help for more details"
			fi
			exit;;
	-e|--exec)			
			if [[ `grep -w "# Command: $2" $plugindir/*.sh` ]]; then
				interactive="no"
				check_root
				enable_log
				check_lock
				check_req
				initialize_program
				while [[ $# -gt 1 && `grep -w "# Command: $2" $plugindir/*.sh` ]]; do			
					for plug in $plugindir/*.sh; do source "$plug"; done
					eval "$2"
					shift
				done
				complete_program
			elif [[ $2 = "list" ]]; then
				SAVEIFS="$IFS"
				IFS=$(echo -en "\n\b")
				for plug in $plugindir/*.sh; do
					command=$(cat $plug | grep "# Command: " | sed 's/# Command: //g')
					name=$(cat $plug | grep "# Name: " | sed 's/# Name: //g')
					echo -e "$command:$name" >> "commands.list"
				done
				IFS=$SAVEIFS
				echo -e "Usage:\tfedorautils --exec [COMMANDS...]"
				echo -e "\v"
				awk '{ printf "\t%-30s%-s\n",$1,$2}' FS=\: "commands.list"
				echo -e "\v"
				echo -e "The \"--exec\" argument does not accept other arguments with it."
				rm -f "commands.list"
				exit
			else
				echo -e "Invalid command \"$2\". Try \"--exec list\" for a list of available commands."
				exit
			fi;;
	-h|--help)
			echo -e "Usage:\tfedorautils [ARGUMENT...]"
			echo -e "\v"
			awk '{ printf "\t%-30s%-s\n",$1,$2}' FS=\: "$datadir/arguments.list"
			echo -e "\v"
			echo -e "See the man page for more help."
			exit;;
	*)
			echo -e "Invalid argument \"$1\". Try \"--help\" for list of arguments."
			exit;;
esac
done
}
