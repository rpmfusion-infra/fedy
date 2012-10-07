# Name: Install Android SDK
# Command: install_androidsdk
# Value: False

install_androidsdk() {
show_func "Installing Android SDK"
if [[ "$(install_androidsdk_test)" = "Installed" ]]; then
	show_status "Android SDK already installed"
else
	source "$plugindir/install_jdk.soft.sh" && install_jdk
	file="android-sdk_r20.0.3-linux.tgz"
	get="http://dl.google.com/android/android-sdk_r20.0.3-linux.tgz"
	get_file
	tar xvf "$file"
	mv android-sdk-linux /opt/
	chmod -R 775 "/opt/android-sdk-linux/"
fi
[[ "$(install_androidsdk_test)" = "Installed" ]]; exit_state
}

install_androidsdk_test() {
if [[ -d /opt/android-sdk-linux/ ]]; then
	printf "Installed"
else
	printf "Not installed"
fi
}
