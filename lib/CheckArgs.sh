function CheckArgs()
{
while [ $# -gt 0 ]; do
case "$1" in
	"") ;;
	"--enable-log") KEEPLOG="YES"
			shift;;
	"--pref-curl") PREFWGET="NO"
			shift;;
	"--use-wget") DOWNAGENT="WGET"
			shift;;
	"--redownload") FORCEDOWN="YES"
			shift;;
	"--force-distro") FORCEDISTRO="YES"
			shift;;
	"--nobakup") KEEPBACKUP="NO"
			shift;;
	"--use-tts") TTS="YES"
			shift;;
	"--debug") ShowLogfile
			exit;;
	"--help") echo -e "Usage:\tfedorautils [ARGUMENT...]"
		echo -e "\v"
		awk '{ printf "\t%-30s%-s\n",$1,$2}' FS=\, "$SCRIPTDIR/arguments.list"
		echo -e "\v"
		echo -e "See the man page for more help."
		exit;;
	*) echo "Invalid argument $ARG. Try --help for list of arguments."
			exit;;
esac
done
}
