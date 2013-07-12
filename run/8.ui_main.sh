# Run: ui_main

ui_main() {
ui_main_build
while menu=$(zenity --list --radiolist --width=300 --height="$((((${#menulist[@]}/3)*25)+200))" --title="$program $version" --text="Welcome to $program. Please select an option." --hide-header --hide-column=2 --column "Select" --column "Command" --column "Section" --ok-label="Select" --cancel-label="Close" "${menulist[@]}"); do
	fun=$(echo $menu | tr "|" "\n")
	for (( i = 0; i < ${#fun[@]} ; i++ )); do
		eval "${fun[$i]}"
	done
	ui_main_build
done
}

ui_main_build() {
unset menulist
while read module; do
	source "$module"
	name=$(grep -i "# Name:" "$module" | sed -e 's/# Name: //')
	command=$(grep -i "# Command:" "$module" | sed -e 's/# Command: //')
	menulist=("${menulist[@]}" "FALSE" "$command" "$name")
done < <(find "$moduledir/" -name *.sh | sort -u)
}
