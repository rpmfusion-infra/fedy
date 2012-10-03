# Name: Block/unblock websites
# Command: block_sites
# Value: False

block_sites() {
while blocksites=$(zenity --list --radiolist --width=300 --height=300 --title="Block/unblock websites" --text="Block or unblock a website for all users.\nIt modifies the \"/etc/hosts\" file." --hide-header --hide-column=2 --column "Select" --column "Command" --column "Option" TRUE "block" "Block a website" FALSE "unblock" "Unblock a website" FALSE "view" "View blocked websites" --ok-label="Select" --cancel-label="Back"); do
	arr=$(echo $blocksites | tr "|" "\n")
	for x in $arr; do
		case $x in
		"block")
			site=$(zenity --entry --title="Block a website" --text="Enter the website to be blocked.\nDo not enter http:// or www.")
			make_backup "/etc/hosts"
			if [ ! "$site" = "" ]; then
				echo "0.0.0.0 $site" >> "/etc/hosts"
				echo "0.0.0.0 www.$site" >> "/etc/hosts"
			else
				show_error "Please enter a website to be blocked."
			fi;;
		"unblock")
			site=$(zenity --entry --title="Unblock a website" --text="Enter the website to be unblocked.\nDo not enter http:// or www.")
			make_backup "/etc/hosts"
			if [ ! "$site" = "" ]; then
				sed -i '/$site/d' "/etc/hosts"
			else
				show_error "Please enter a website to be unblocked."
			fi;;
		"view")
			grep "0.0.0.0" "/etc/hosts" >> "sites.txt"
			zenity --text-info --title="Blocked websites" --filename="sites.txt" --ok-label="Ok" --cancel-label="Back"
			rm -f "sites.txt";;
		esac
	done
	exit_state
done
}
