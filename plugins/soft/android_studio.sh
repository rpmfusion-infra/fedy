# Name: Install Android Studio
# Command: android_studio
 
android_studio() {
show_func "Installing Android Studio"
if [[ "$(android_studio_test)" = "Installed" ]]; then
	show_status "Android Studio already installed"
else
	show_msg "Getting latest version"
	get_file_quiet "http://developer.android.com/sdk/index.html" "android.html"
	get=$(cat android.html | grep -o "https://dl.google.com/dl/android/studio/ide-zips/[0-9.]*/android-studio-ide-[0-9.]*-linux.zip" | head -n 1)
	file=${get##*/}
	get_file

	if [[ -f "$file" ]]; then
		show_msg "Installing files"
		rm -rf "/opt/android-studio"
		unzip -xq "$file" -d "/opt"
		ln -sf "/opt/android-studio/bin/studio.sh" "/usr/bin/android-studio"
		cp -f "/opt/android-studio/bin/androidstudio.svg" "/usr/share/icons/hicolor/scalable/apps/android-studio.svg"
		gtk-update-icon-cache -f -t /usr/share/icons/hicolor > /dev/null 2>&1
 
cat <<EOF | tee /usr/share/applications/android-studio.desktop > /dev/null 2>&1
[Desktop Entry]
Name=Android Studio
Icon=android-studio
Comment=Develop Apps for Android
Exec=android-studio
Terminal=false
Type=Application
StartupNotify=true
Categories=IDE;Development;
Keywords=Idea;Java;Android;SDK;IDE;
EOF
	fi
fi
[[ "$(android_studio_test)" = "Installed" ]]; exit_state
}
 
android_studio_undo() {
show_msg "Uninstalling Android Studio"
rm -f "/usr/bin/android-studio"
rm -f "/usr/share/icons/hicolor/scalable/apps/android-studio.svg"
rm -rf "/opt/android-studio"
[[ ! "$(android_studio_test)" = "Installed" ]]; exit_state
}
 
android_studio_test() {
if [[ -f "/opt/android-studio/bin/studio.sh" ]]; then
	echo "Installed"
else
	echo "Not Installed"
fi
} 