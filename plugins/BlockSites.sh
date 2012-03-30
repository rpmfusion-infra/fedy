function M_F_BlockSites # Block/unblock websites
{
BlockSites
}

function BlockSites()
{
block=$(zenity --list --width=350 --height=200 --title="Block/unblock websites" --text="Block or unblock a website for all users.\nIt modifies the \"/etc/hosts\" file." --radiolist  --column "Select" --column "Options" TRUE "Block a website" FALSE "Unblock a website" FALSE "View blocked websites" --hide-header --ok-label="Select" --cancel-label="Back")
arr=$(echo $block | tr "\:" "\n")
for x in $arr
do
	case $x in
	"Block") site=`zenity --entry --title="Block a website" --text="Enter the website to be blocked.\nDo not enter http:// or www."`
		if [ "$KEEPBACKUP" = "YES" ]; then
		cp /etc/hosts /etc/hosts.bak
		fi
		if [ ! "$site" = "" ]; then
		echo "0.0.0.0 $site" >> /etc/hosts
		echo "0.0.0.0 www.$site" >> /etc/hosts
		else
		ErrorMsg "Please enter a website to be blocked."
		fi;;
	"Unblock") site=`zenity --entry --title="Unblock a website" --text="Enter the website to be unblocked.\nDo not enter http:// or www."`
		if [ "$KEEPBACKUP" = "YES" ]; then
		cp /etc/hosts /etc/hosts.bak
		fi
		if [ ! "$site" = "" ]; then
		sed -i /"$site"/d /etc/hosts
		else
		ErrorMsg "Please enter a website to be unblocked."
		fi;;
	"View") grep "0.0.0.0" /etc/hosts >> sites.txt
		zenity --text-info --title="Blocked websites" --filename="sites.txt" --ok-label="Ok" --cancel-label="Back"
		rm -f sites.txt;;
	esac
done
if [ $? = "0" ]; then
Success
else
Failure
fi
Misc
}
