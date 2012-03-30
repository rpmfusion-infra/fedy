function CheckArgs()
{
case "$ARG" in
"") ;;
"--enable-log") KEEPLOG="YES";;
"--redownload") FORCE="YES";;
"--force-distro") FORCEDISTRO="YES";;
"--nobakup") KEEPBACKUP="NO";;
"--debug") ShowLogfile
		exit;;
"--help") ShowLicense
		echo -e "Usage:\tfedorautils [argument]"
		echo -e "\v"
		awk '{ printf "\t%-35s%-s\n",$1,$2}' FS=\, "$SCRIPTDIR/arguments.list"
		echo -e "\v"
		echo -e "Run as root with no arguments for the normal GUI. Note that if you run $PROGRAM without root privilleges, it will try to accquire root previlleges first and all arguments will reset and won't work."
		exit;;
*) echo "Invalid argument $ARG. Try --help for list of arguments."
		exit;;
esac
}
