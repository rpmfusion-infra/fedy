# Name: Install Android SDK
# Command: install_androidsdk
# Value: False

install_androidsdk() {
source "$plugindir/install_jdk.soft.sh" && install_jdk
show_func "Installing Android SDK"
if [[ -e /opt/android-sdk-linux/ ]]; then
	show_status "Android SDK already installed"
else
	file="android-sdk_r20.0.3-linux.tgz"
	get="http://dl.google.com/android/android-sdk_r20.0.3-linux.tgz"
	get_file
	tar xvf "$file"
	mv android-sdk-linux /opt/
	chmod -R 775 "/opt/android-sdk-linux/"
fi
[[ -e /opt/android-sdk-linux/ ]]; exit_state
}
