# Name: Install Android SDK
# Command: install_androidsdk

install_androidsdk() {
show_func "Installing Android SDK"
if [[ "$(install_androidsdk_test)" = "Installed" && ! "$reinstall" = "yes" ]]; then
    show_status "Android SDK already installed"
else
    show_msg "Fetching webpage"
    get_file_quiet "http://developer.android.com/sdk/index.html" "androidsdk.htm"
    get=$(grep -o "http://dl.google.com/android/android-sdk_r[0-9]*\.[0-9]*\.[0-9]*-linux.tgz" "androidsdk.htm" | head -n 1)
    file=${get##*/}
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
