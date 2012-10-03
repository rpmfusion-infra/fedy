get_file() {
show_msg "Downloading from: $get"
show_msg "Saving to: $file"
notify_send "Downloading:" "Downloading $file, it may take some time depending on your connection"
if [[ "$downagent" = "wget" ]]; then
	if [[ "$forcedown" = "yes" ]]; then
		wget --no-cookies "$get" -O "$file" "$@"
	else
		wget --no-cookies -c "$get" -O "$file" "$@"
	fi
else
	if [[ "$forcedown" = "yes" ]]; then
		curl -L -# "$get" -o "$file" "$@"
	else
		curl -C - -L -# "$get" -o "$file" "$@"
	fi
fi
if [[ $? -eq 0 && -s "$workingdir/$file" ]]; then
	show_msg "Download successful!"
	[[ "$keepdownloads" = "yes" ]] && cp -f "$file" "$downloadsdir"
else
	show_error "Error downloading $file!"
fi
}
