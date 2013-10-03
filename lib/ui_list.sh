ui_list() {
listsection="$1"
listtype="$2"
listtitle="$3"
ui_list_build
while list=$(dialog_show --list $listtype --width=450 --height="$((((${#plugs[@]}/3)*25)+150))" --title="$listtitle" --no-headers --hide-column="2" --print-column="2" --column "Select:CHK" --column "Command" --column "Plugin" --button="Back:1" --button="Select:0" "${plugs[@]}"); do
	fun=$(echo $list | tr "|" "\n")
	for (( i = 0; i < ${#fun[@]} ; i++ )); do
		eval "${fun[$i]}"
	done
	ui_list_build
done
}

ui_list_build() {
unset plugs
while read plug; do
	source "$plug"
	name=$(grep "# Name:" "$plug" | sed -e 's/# Name: //')
	command=$(grep "# Command:" "$plug" | sed -e 's/# Command: //')
	[[ `grep "${command}_test()" "$plug"` ]] && name="$name ($(${command}_test))"
	[[ `grep "${command}_hide()" "$plug"` && "$(eval ${command}_hide)" = "true" ]] || plugs=("${plugs[@]}" "FALSE" "$command" "$name")
done < <(find "$plugindir/$listsection/" -name *.sh | sort -u)
}
