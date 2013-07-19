check_update() {
show_msg "Checking update"
get_file_quiet "https://github.com/satya164/fedorautils/tags.atom" "fedorautils.atom"
dltag=$(grep "<title>v.*</title>" "fedorautils.atom" | grep -o "v[0-9].[0-9].[0-9]" | head -n 1)
dlver=${dltag#v}
if [[ $dlver > $version ]]; then
	get_file_quiet "https://github.com/satya164/fedorautils/raw/v${dlver}/CHANGELOG" "changelog-${dlver}.txt"
	prevdate=$(grep '^Changelog.*' "changelog-${dlver}.txt" | sed -n 2p)
	changelog=$(sed -e /"$prevdate"/q "changelog-${dlver}.txt" | head -n -2)
	updatestat="available"
elif [[ $dlver = $version ]]; then
	updatestat="uptodate"
fi
}

install_update() {
show_msg "Installing update"
get="https://github.com/satya164/fedorautils/archive/v${dlver}.tar.gz"
file="fedorautils.tar.gz"
get_file
tar -xzf "$file"
make uninstall -C fedorautils-${dlver}
make install -C fedorautils-${dlver}
}

show_update() {
check_update
if [[ "$updatestat" = "available" ]]; then
	show_msg "Update available!"
	if [[ ! "$interactive" = "no" ]]; then
		zenity --question --title="Update available" --text="$changelog" --ok-label "Install update" --cancel-label "Ignore"
		if [[ $? -eq 0 ]]; then
			install_update
			zenity --info --title="Update installed" --text="Please restart $program to avoid problems."
		fi
	fi
fi
}
