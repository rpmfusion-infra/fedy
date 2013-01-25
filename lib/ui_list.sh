ui_list() {
listsection="$1"
listtype="$2"
listtitle="$3"
build_list
while list=$(zenity --list $listtype --width=450 --height="$((((${#plugs[@]}/3)*25)+150))" --title="$listtitle" --text="" --hide-header --hide-column=2 --column "Select" --column "Command" --column "Plugin" --ok-label="Select" --cancel-label="Back" "${plugs[@]}"); do
	fun=$(echo $list | tr "|" "\n")
	for (( i = 0; i < ${#fun[@]} ; i++ )); do
		eval "${fun[$i]}"
	done
	build_list
done
}

build_list() {
unset plugs
while read plug; do
	source "$plug"
	name=$(grep "# Name:" "$plug" | sed -e 's/# Name: //')
	command=$(grep "# Command:" "$plug" | sed -e 's/# Command: //')
	value=$(grep "# Value:" "$plug" | sed -e 's/# Value: //')
	[[ `grep "${command}_test()" "$plug"` ]] && name="$name ($(${command}_test))"
	[[ `grep "${command}_hide()" "$plug"` && "$(eval ${command}_hide)" = "true" ]] || plugs=("${plugs[@]}" "$value" "$command" "$name")
done < <(find "$plugindir/" -name *.$listsection.sh | sort -u)
}
