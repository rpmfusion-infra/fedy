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
process_font andale32.exe
process_font arial32.exe
process_font arialb32.exe
process_font comic32.exe
process_font courie32.exe
process_font georgi32.exe
process_font impact32.exe
process_font times32.exe
process_font trebuc32.exe
process_font verdan32.exe
process_font webdin32.exe
process_font wd97vwr32.exe
mv "$workingdir/msttcorefonts" "/usr/share/fonts/"
show_msg "Rebuilding font cache..."
fc-cache -f -v
fi
[[ -d /usr/share/fonts/msttcorefonts ]]; exit_state
}

process_font() {
font="$1"
get="http://downloads.sourceforge.net/corefonts/$font"
file="corefonts/$font"
get_file
cabextract -L -d "$workingdir/msttcorefonts" "$file"
}
