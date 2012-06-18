function CheckArgs()
{
case "$ARG" in
"") ;;
"--enable-log") KEEPLOG="YES";;
"--pref-curl") PREFWGET="NO";;
"--use-wget") DOWNAGENT="WGET";;
"--redownload") FORCEDOWN="YES";;
"--force-distro") FORCEDISTRO="YES";;
"--nobakup") KEEPBACKUP="NO";;
"--use-tts") TTS="YES";;
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
}
