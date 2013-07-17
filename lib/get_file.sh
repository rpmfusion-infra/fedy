get_file() {
if [[ "$get" = "" || "$file" = "" ]]; then
	show_error "Error resolving download link!"
else
	show_msg "Downloading from: $get"
	show_msg "Saving to: $file"
	notify_send -i gtk-save "Downloading:" "Downloading $file, it may take some time depending on your connection"
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
	if [[ -s "$file" ]]; then
		show_msg "Download successful!"
		[[ "$keepdownloads" = "yes" ]] && cp -f "$file" "$downloadsdir"
	else
		show_error "Error downloading $file!"
	fi
fi
}

get_file_quiet() {
if [[ "$downagent" = "wget" ]]; then
	wget -q "$1" -O "$2"
else
	touch "$2"
	curl -s -L "$1" -o "$2"
fi
}
