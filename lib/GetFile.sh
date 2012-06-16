function GetFile()
{
if [ ! -f "$WORKINGDIR/$file" ] || [ "$FORCEDOWN" = "YES" ]; then
	ShowMsg "Downloading from: $get"
	ShowMsg "Saving to: $file"
	Notify "Downloading:" "Downloading $file, it may take some time depending on your connection"
	if [ "$DOWNAGENT" = "WGET" ]; then
		wget -c "$get" -O "$file"
	else
		curl -L -# "$get" -o "$file"
	fi
	if [ -f "$WORKINGDIR/$file" ]; then
		ShowMsg "Download successful!"
		if [ "$KEEPDOWNLOADS" = "YES" ]; then
			cp -f "$file" "$DOWNLOADSDIR"
		fi
	else
		ErrorMsg "Error downloading $file!"
	fi
else
	ShowMsg "$file already present, skipping download"
fi
}
