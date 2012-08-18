check_args() {
while [[ $# -gt 0 ]]; do
case "$1" in
	"") ;;
	"--enable-log") keeplog="yes"
			shift;;
	"--pref-curl") prefwget="no"
			shift;;
	"--use-wget") downagent="wget"
			shift;;
	"--redownload") forcedown="yes"
			shift;;
	"--force-distro") forcedistro="yes"
			shift;;
	"--nobakup") keepbackup="no"
			shift;;
	"--use-tts") tts="yes"
			shift;;
	"--debug") if [[ -e "$logfile" ]]; then
			cat "$logfile"
		else
			echo -e "No logfile exists. Try running Fedora Utils with logging enabled. Use --help for more details"
		fi
		exit;;
	"--help") echo -e "Usage:\tfedorautils [ARGUMENT...]"
		echo -e "\v"
		awk '{ printf "\t%-30s%-s\n",$1,$2}' FS=\, "$scriptdir/data/arguments.list"
		echo -e "\v"
		echo -e "See the man page for more help."
		exit;;
	*) echo "Invalid argument $1. Try --help for list of arguments."
			exit;;
esac
done
}
