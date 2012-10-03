# Name: Install Microsoft core fonts
# Command: core_fonts
# Value: True

core_fonts() {
show_func "Installing Microsoft Truetype fonts"
if [[ -d /usr/share/fonts/msttcorefonts ]]; then
	show_status "Microsoft Truetype fonts already installed"
else
	[[ -e /usr/bin/cabextract ]] || install_pkg cabextract
	mkdir -p "$workingdir/corefonts"
	fontlist=( "andale32.exe" "arial32.exe" "arialb32.exe" "comic32.exe" "courie32.exe" "georgi32.exe" "impact32.exe" "times32.exe" "trebuc32.exe" "verdan32.exe" "webdin32.exe" "wd97vwr32.exe" )
	for font in "${fontlist[@]}"; do
		get="http://downloads.sourceforge.net/corefonts/$font"
		file="corefonts/$font"
		get_file
		cabextract -L -d "$workingdir/msttcorefonts" "$file"
	done
	mv "$workingdir/msttcorefonts" "/usr/share/fonts/"
	show_msg "Rebuilding font cache..."
	fc-cache -f -v
fi
[[ -d /usr/share/fonts/msttcorefonts ]]; exit_state
}
