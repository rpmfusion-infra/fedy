function I_F_AndroidSDK # Install Android SDK
{
AndroidSDK
}

function AndroidSDK()
{
InstallJDK
ShowFunc "Installing Android SDK"
if [ -e /opt/android-sdk-linux/tools/android ]; then
StatusMsg "Android SDK already installed"
else
file="android-sdk_r18-linux.tgz"
get="http://dl.google.com/android/android-sdk_r18-linux.tgz"
GetFile
tar xvf "$file"
mv android-sdk-linux /opt/
file="platform-tools_r10-linux.zip"
get="http://dl-ssl.google.com/android/repository/platform-tools_r10-linux.zip"
GetFile
unzip -q "$file"
mv platform-tools /opt/android-sdk-linux/
fi
chmod -R 775 "/opt/android-sdk-linux/"
if [ -e /opt/android-sdk-linux/tools/ ] && [ -e /opt/android-sdk-linux/platform-tools/ ]; then
echo -e "Configuring Android SDK..."
cat <<EOF | tee /etc/profile.d/androidsdk.sh
export PATH="/opt/android-sdk-linux/tools/:/opt/android-sdk-linux/platform-tools/:\${PATH}"
EOF
fi
if [ -e /opt/android-sdk-linux/tools/android ]; then
Success
else
Failure
fi
}
