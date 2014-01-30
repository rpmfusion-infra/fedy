# Name: Install Skype
# Command: skype_linux

skype_linux() {
show_func "Installing Skype"
if [[ "$(skype_linux_test)" = "Installed" ]]; then
    show_status "Skype already installed"
else
    get32="http://www.skype.com/go/getskype-linux-fc10"
    file32="skype-fedora.i586.rpm"
    get64="$get32"
    file64="$file32"
    process_pkg
fi
[[ "$(skype_linux_test)" = "Installed" ]]; exit_state
}

skype_linux_undo() {
show_func "Uninstalling Skype"
erase_pkg skype
[[ ! "$(skype_linux_test)" = "Installed" ]]; exit_state
}

skype_linux_test() {
query_pkg skype
if [[ $? -eq 0 ]]; then
    printf "Installed"
else
    printf "Not installed"
fi
}
