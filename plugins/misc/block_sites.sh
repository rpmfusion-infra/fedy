# Name: Block/unblock websites
# Command: block_sites

block_sites() {
while blocksites=$(show_dialog --list --radiolist --width=300 --height=300 --title="Block/unblock websites" --text="Block or unblock a website for all users.\nIt modifies the \"/etc/hosts\" file." --no-headers --hide-column="2" --print-column="2" --column "Select:CHK" --column "Command" --column "Option" TRUE "block" "Block a website" FALSE "unblock" "Unblock a website" FALSE "view" "View blocked websites" --button="Back:1" --button="Select:0"); do
	arr=$(echo $blocksites | tr "|" "\n")
	for x in $arr; do
		case $x in
		"block")
			site=$(show_dialog --entry --title="Block a website" --text="Enter the website to be blocked.\nDo not enter http:// or www." --button="Back:1" --button="Block:0")
			show_func "Adding $site to blocked list"
			make_backup "/etc/hosts"
			if [ ! "$site" = "" ]; then
				echo "0.0.0.0 $site" >> "/etc/hosts"
				echo "0.0.0.0 www.$site" >> "/etc/hosts"
			else
				show_err "No website address entered!"
			fi;;
		"unblock")
			site=$(show_dialog --entry --title="Unblock a website" --text="Enter the website to be unblocked.\nDo not enter http:// or www." --button="Back:1" --button="Unblock:0")
			show_func "Removing $site from blocked list"
			make_backup "/etc/hosts"
			if [ ! "$site" = "" ]; then
				sed -i "/$site/d" "/etc/hosts"
			else
				show_err "No website address entered!"
			fi;;
		"view")
			show_func "Getting list of blocked websites"
			grep "0.0.0.0" "/etc/hosts" >> "sites.txt"
			show_dialog --text-info --width=400 --height=400 --title="Blocked websites" --filename="sites.txt" --button="Back:0"
			rm -f "sites.txt";;
		esac
	done
	exit_state
done
}
