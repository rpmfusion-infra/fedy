function U_F_InstallJava # Install Oracle Java Runtime Environment
{
InstallJava
}

function InstallJava()
{
ShowFunc "Installing Java runtime Environment"
if [ -e /usr/java/jre1.7.0_*/bin/java ]; then
StatusMsg "Java already installed"
else
if [ $(uname -i) = "i386" ]; then
file="jre-7u4-linux-i586.rpm"
get="http://download.oracle.com/otn-pub/java/jdk/7u4-b20/jre-7u4-linux-i586.rpm"
elif [ $(uname -i) = "x86_64" ]; then
file="jre-7u4-linux-x64.rpm"
get="http://download.oracle.com/otn-pub/java/jdk/7u4-b20/jre-7u4-linux-x64.rpm"
fi
JavaDown
InstallLocalPkg "$file"
fi
echo -e "Setting up Oracle Java..."
alternatives --install /usr/bin/java java /usr/java/default/bin/java 20000
echo -e "Setting up Java plugin for firefox..."
if [ $(uname -i) = "i386" ]; then
alternatives --install /usr/lib/mozilla/plugins/libjavaplugin.so libjavaplugin.so /usr/java/default/lib/i386/libnpjp2.so 20000
elif [ $(uname -i) = "x86_64" ]; then
alternatives --install /usr/lib64/mozilla/plugins/libjavaplugin.so libjavaplugin.so.x86_64 /usr/java/default/lib/amd64/libnpjp2.so 20000
fi
if [ -e /usr/java/jre1.7.0_*/bin/java ]; then
Success
else
Failure
fi
}

function JavaDown()
{
if [ ! -f "$WORKINGDIR/$file" ] || [ "$FORCEDOWN" = "YES" ]; then
	ShowMsg "Downloading from: $get"
	ShowMsg "Saving to: $file"
	Notify "Downloading:" "Downloading $file, it may take some time depending on your connection"
	# we need to get the cookie to download Java
	curl -s "http://launchpadlibrarian.net/98645053/cookie.txt" -o "cookie.txt"
	curl -L -O -# --cookie cookie.txt "$get"
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
