function ViewHelp # View Help
{
if [ -e /etc/yum.repos.d/fedorautils.repo ]; then
REPOTEXT="Remove"
else
REPOTEXT="Add"
fi
shell=$(zenity --list --width=300 --height=300 --title="$PROGRAM Help" --text="$PROGRAM $VERSION (C) Satyajit Sahoo\nhttp:\/\/fedorautils.sf.net" --radiolist  --column "Select" --column "Options" TRUE "$REPOTEXT Fedora Utils repo" FALSE "Report a issue" FALSE "Visit wiki" FALSE "View changelog" --ok-label="Select" --hide-header --cancel-label="Back")
if [ $? == 0 ]; then
	arr=$(echo $shell | tr "\:" "\n")
	for x in $arr
	do
		case $x in
		"repo") if [ -e /etc/yum.repos.d/fedorautils.repo ]; then
			ShowFunc "Removing Fedora Utils repo"
			rm -f /etc/yum.repos.d/fedorautils.repo
			else
			ShowFunc "Adding Fedora Utils repo"
			echo "[fedorautils] 
			name=Fedora Utils
			baseurl=http://master.dl.sourceforge.net/project/fedorautils/
			enabled=1
			metadata_expire=1d
			gpgcheck=0" > /etc/yum.repos.d/fedorautils.repo
			fi;;
		"issue") ShowMsg "Opening Browser..."
				python -mwebbrowser "http://github.com/satya164/fedorautils/issues";;
		"wiki") ShowMsg "Opening Browser..."
				python -mwebbrowser "http://github.com/satya164/fedorautils/wiki";;
		"changelog") ShowMsg "Fetching changelog..."
			curl -s http://master.dl.sourceforge.net/project/fedorautils/README -o changelog.txt
			if [ -e changelog.txt ]; then
			zenity --text-info --width=600 --height=600 --title="Changelog" --filename="changelog.txt" --ok-label="Ok" --cancel-label="Back"
			rm -f changelog.txt
			else
			ErrorMsg "Error fetching changelog! Do you have an active internet connection?"
			fi;;
		esac
	done
fi
Main
}
