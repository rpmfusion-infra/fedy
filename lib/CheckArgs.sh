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
	"--help") ShowLicense
			echo -e "Usage:\tfedorautils [argument]"
			echo -e "\v"
			awk '{ printf "\t%-30s%-s\n",$1,$2}' FS=\, "$SCRIPTDIR/arguments.list"
			echo -e "\v"
			echo -e "Run as root with no arguments for the normal GUI. Note that if you run $PROGRAM without root privilleges, it will try to accquire root previlleges first and all arguments will reset and won't work. You can also use configuration file to set variables instead of using arguments."
			exit;;
	*) echo "Invalid argument $ARG. Try --help for list of arguments."
			exit;;
esac
done
}
