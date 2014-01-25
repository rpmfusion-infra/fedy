# Name: Install Kingsoft Office
# Command: kingsoft_office

kingsoft_office() {
show_func "Installing Kingsoft Office"
if [[ "$(kingsoft_office_test)" = "Installed" ]]; then
    show_status "Kingsoft Office already installed"
else
    show_msg "Getting latest version"
    get_file_quiet "http://wps-community.org/download.html" "kingsoft.htm"
    get32=$(cat 'kingsoft.htm' | tr ' ' '\n' | grep -o "https\?://.*/kingsoft-office-.*.rpm" | head -n 1)
    file32=${get32##*/}
    get64="$get32"
    file64="$file32"
    process_pkg
fi
[[ "$(kingsoft_office_test)" = "Installed" ]]; exit_state
}

kingsoft_office_undo() {
show_func "Uninstalling Kingsoft Office"
erase_pkg kingsoft-office
[[ ! "$(kingsoft_office_test)" = "Installed" ]]; exit_state
}

kingsoft_office_test() {
query_pkg kingsoft-office
if [[ $? -eq 0 ]]; then
    printf "Installed"
else
    printf "Not installed"
fi
}
