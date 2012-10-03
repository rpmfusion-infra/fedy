clean_temp() {
if [[ $(whoami) = "root" ]]; then
	if [[ -d "$downloadsdir" ]]; then
		chown -R "$user" "$downloadsdir"
		# Delete Downloads directory if it is empty
		rmdir --ignore-fail-on-non-empty "$downloadsdir"
	fi
	rm -rf "$workingdir" "$lockfile"
	[[ $? -eq 0 ]] && show_status "Temporary directory cleaned!"
fi
}
