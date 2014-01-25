# Name: Install Oracle Java
# Command: oracle_jre

oracle_jre() {
show_func "Installing Oracle JRE"
if [[ "$(oracle_jre_test)" = "Installed" && ! "$reinstall" = "yes" ]]; then
    show_status "Oracle JRE already installed"
else
    show_msg "Getting latest version"
    get_file_quiet "http://www.oracle.com/technetwork/java/javase/downloads/index.html" "java.htm"
    dlurl=$(cat "java.htm" | tr ' ' '\n' | grep "/technetwork/java/javase/downloads/jre7" | head -n 1 | cut -d\" -f 2 | sed -e 's/^/http:\/\/www.oracle.com/')
    get_file_quiet "$dlurl" "jre.htm"
    get32=$(grep "Linux x86" "jre.htm" | grep ".rpm" | cut -d\" -f 12 | grep -v demos | head -n 1)
    file32=${get32##*/}
    get64=$(grep "Linux x64" "jre.htm" | grep ".rpm" | cut -d\" -f 12 | grep -v demos | head -n 1)
    file64=${get64##*/}
    process_pkg --header "Cookie: gpw_e24=www.oracle.com"
    show_msg "Setting up Oracle Java"
    alternatives --install /usr/bin/java java /usr/java/latest/bin/java 200000
    alternatives --auto java
    show_msg "Setting up Java plugin for firefox"
    if [[ "$arch" = "32" ]]; then
        alternatives --install /usr/lib/mozilla/plugins/libjavaplugin.so libjavaplugin.so /usr/java/latest/lib/i386/libnpjp2.so 200000
        alternatives --auto libjavaplugin.so
    elif [[ "$arch" = "64" ]]; then
        alternatives --install /usr/lib64/mozilla/plugins/libjavaplugin.so libjavaplugin.so.x86_64 /usr/java/latest/lib/amd64/libnpjp2.so 200000
        alternatives --auto libjavaplugin.so.x86_64
    fi
fi
[[ "$(oracle_jre_test)" = "Installed" ]]; exit_state
}

oracle_jre_undo() {
show_func "Uninstalling Oracle JRE"
erase_pkg jre
alternatives --remove java /usr/java/latest/bin/java
alternatives --auto java
if [[ "$arch" = "32" ]]; then
    alternatives --remove libjavaplugin.so /usr/java/latest/jre/lib/i386/libnpjp2.so
    alternatives --auto libjavaplugin.so
elif [[ "$arch" = "64" ]]; then
    alternatives --remove libjavaplugin.so.x86_64 /usr/java/latest/jre/lib/amd64/libnpjp2.so
    alternatives --auto libjavaplugin.so.x86_64
fi
[[ ! "$(oracle_jre_test)" = "Installed" ]]; exit_state
}

oracle_jre_test() {
ls /usr/java/jre* > /dev/null 2>&1
if [[ $? -eq 0 ]]; then
    printf "Installed"
else
    printf "Not installed"
fi
}
