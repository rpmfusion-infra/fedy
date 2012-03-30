function U_T_InstallJava # Install Oracle Java Runtime Environment
{
InstallJava
}

function InstallJava()
{
ShowFunc "Installing Java runtime Environment"
if [ -e /usr/java/jre1.7.0_03/bin/java ]; then
StatusMsg "Java already installed"
else
file32="jre-7u3-linux-i586.rpm"
get32="http://download.oracle.com/otn-pub/java/jdk/7u3-b04/jre-7u3-linux-i586.rpm"
file64="jre-7u3-linux-x64.rpm"
get64="http://download.oracle.com/otn-pub/java/jdk/7u3-b04/jre-7u3-linux-x64.rpm"
ProcessPkg
fi
echo -e "Setting up Oracle Java..."
alternatives --install /usr/bin/java java /usr/java/default/bin/java 20000
echo -e "Setting up Java plugin for firefox..."
if [ $(uname -i) = "i386" ]; then
alternatives --install /usr/lib/mozilla/plugins/libjavaplugin.so libjavaplugin.so /usr/java/default/lib/i386/libnpjp2.so 20000
elif [ $(uname -i) = "x86_64" ]; then
alternatives --install /usr/lib64/mozilla/plugins/libjavaplugin.so libjavaplugin.so.x86_64 /usr/java/default/lib/amd64/libnpjp2.so 20000
fi
if [ -e /usr/java/jre1.7.0_03/bin/java ]; then
Success
else
Failure
fi
}
