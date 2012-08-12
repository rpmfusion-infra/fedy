clean_temp() {
if [[ -d "$workingdir" ]]; then
rm -rf "$workingdir"
fi
if [[ -d "$downloadsdir" ]]; then
chown -R "$user" "$downloadsdir"
# Delete Downloads directory if it is empty
rmdir --ignore-fail-on-non-empty $downloadsdir
show_status "Temporary directory cleaned"
fi
# Delete lockfile
if [[ $(whoami) = "root" ]]; then
	rm -f "$lockfile"
	if [[ ! $? = "0" ]]; then
	   exit 1;
	fi
fi
}
