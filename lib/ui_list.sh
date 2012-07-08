ui_list() {
section="$1"
listtype="$2"
title="$3"
SAVEIFS=$IFS;
IFS=$(echo -en "\n\b")
plugins="$plugindir/*.$section.sh"
for plug in $plugins; do
	[[ -f "$plug" ]] || continue
	name=$(grep -i "# Name:" "$plug" | sed -e 's/# Name: //')
	command=$(grep -i "# Command:" "$plug" | sed -e 's/# Command: //')
	value=$(grep -i "# Value:" "$plug" | sed -e 's/# Value: //')
	plugs=("${plugs[@]}" "$value" "$command" "$name")
	source "$plug"
done
while list=$(zenity --list $listtype --width=450 --height=650 --title="$title" --hide-column=2 --column "Select" --column "Command" --column "Name" --ok-label="Apply" --cancel-label="Back" "${plugs[@]}"); do
	fun=$(echo $list | tr "|" "\n")
	for (( i = 0; i < ${#fun[@]} ; i++ )); do
		eval "${fun[$i]}"
	done
done
unset plugs
IFS=$SAVEIFS
}
