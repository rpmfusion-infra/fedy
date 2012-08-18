# Name: Install Oracle Java
# Command: install_jre
# Value: False

install_jre() {
show_func "Installing Oracle JRE"
if [[ -e /usr/java/jdk1.7.0_*/bin/java ]]; then
show_status "Oracle JRE already installed"
else
cookie="$datadir/java.cookie"
file32="jre-7u5-linux-i586.rpm"
get32="http://download.oracle.com/otn-pub/java/jdk/7u5-b06/jre-7u5-linux-i586.rpm"
file64="jre-7u5-linux-x64.rpm"
get64="http://download.oracle.com/otn-pub/java/jdk/7u5-b06/jre-7u5-linux-x64.rpm"
process_pkg
show_msg "Setting up Oracle Java..."
alternatives --install /usr/bin/java java /usr/java/default/bin/java 20000
fi
show_msg "Setting up Java plugin for firefox..."
if [[ $(uname -i) = "i386" ]]; then
alternatives --install /usr/lib/mozilla/plugins/libjavaplugin.so libjavaplugin.so /usr/java/default/lib/i386/libnpjp2.so 20000
elif [[ $(uname -i) = "x86_64" ]]; then
alternatives --install /usr/lib64/mozilla/plugins/libjavaplugin.so libjavaplugin.so.x86_64 /usr/java/default/lib/amd64/libnpjp2.so 20000
fi
[[ -e /usr/java/jdk1.7.0_*/bin/java ]]; exit_state
}
