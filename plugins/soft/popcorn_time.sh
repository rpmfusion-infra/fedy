# Name: Install Popcorn Time
# Command: popcorn_time

popcorn_time() {
show_func "Installing Popcorn Time"
if [[ "$(popcorn_time_test)" = "Installed" ]]; then
show_status "Popcorn Time already installed"
else
show_msg "Getting latest version"
get_file_quiet "https://popcorntime.io" "popcorntime.html"
get=$(cat popcorntime.html | grep -o "https://get.popcorntime.io/build/Popcorn-Time-[0-9.]*-Linux${arch}.tar.xz" | head -n 1)
file=${get##*/}
get_file
if [[ -f "$file" ]]; then
show_msg "Installing files"
mkdir "/opt/Popcorn-Time"
tar -xf "$file" -C "/opt/Popcorn-Time"
unzip "/opt/Popcorn-Time/package.nw" "src/app/images/icon.png" -d "/opt/Popcorn-Time"
mv "/opt/Popcorn-Time/src/app/images/icon.png" "/opt/Popcorn-Time/Popcorn_Time.png"
rm -f -R "/opt/Popcorn-Time/src" "/opt/Popcorn-Time/$file"
ln -sf "/opt/Popcorn-Time/Popcorn-Time" "/usr/bin/popcorn"
cat <<EOF | tee /usr/share/applications/popcorn-time.desktop > /dev/null 2>&1
[Desktop Entry]
Name=Popcorn Time
Icon=/opt/Popcorn-Time/Popcorn_Time.png
Comment=A whole new way to watch movies and TV
Exec=popcorn
Terminal=false
Type=Application
StartupNotify=true
Categories=Video;BitTorrent
Keywords=Popcorn;Video;torrent;stream
EOF
fi
fi
[[ "$(popcorn_time_test)" = "Installed" ]]; exit_state
}

popcorn_time_undo() {
show_func "Uninstalling Popcorn Time"
rm -f "/usr/bin/popcorn"
rm -f "/usr/share/applications/popcorn-time.desktop"
rm -rf "/opt/Popcorn-Time"
[[ ! "$(popcorn_time_test)" = "Installed" ]]; exit_state
}

popcorn_time_test() {
if [[ -f /opt/Popcorn-Time/Popcorn-Time ]]; then
printf "Installed"
else
printf "Not installed"
fi
} 