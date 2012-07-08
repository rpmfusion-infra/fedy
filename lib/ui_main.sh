ui_main() {
modules="$moduledir/*.sh"
for module in $modules; do
	[[ -f "$module" ]] || continue
	name=$(grep -i "# Name:" "$module" | sed -e 's/# Name: //')
	command=$(grep -i "# Command:" "$module" | sed -e 's/# Command: //')
	menulist=("${menulist[@]}" "FALSE" "$command" "$name")
	source "$module"
done
while menu=$(zenity --list --radiolist --width=300 --height=350 --title="$program $version" --text="Welcome to $program. Please choose an option." --hide-column=2 --column "Select" --column "Command" --column "Name" --ok-label="Select" --cancel-label="Close" "${menulist[@]}"); do
	fun=$(echo $menu | tr "|" "\n")
	for (( i = 0; i < ${#fun[@]} ; i++ )); do
		eval "${fun[$i]}"
	done
done
unset menulist
}
