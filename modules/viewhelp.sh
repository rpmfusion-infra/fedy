# Name: View help
# Command: view_help

view_help() {
while shell=$(show_dialog --list --radiolist --width=300 --height=300 --title="$program Help" --text="$program $version © Satyajit Sahoo\nsatya164.github.io/fedorautils" --no-headers --hide-column="2" --print-column="2" --column "Select:CHK" --column "Command" --column "Options" TRUE "update" "Check update" FALSE "repo" "Install repofile" FALSE "issue" "Report an issue" FALSE "wiki" "Visit the wiki" FALSE "changelog" "View changelog" FALSE "logfile" "View logfile" --button="Back:1" --button="Select:0"); do
    arr=$(echo $shell | tr "|" "\n")
    for x in $arr; do
        case $x in
        "update")
            show_update
            if [[ "$updatestat" = "uptodate" ]]; then
                show_status "Fedora Utils is up-to-date"
                show_dialog --timeout="5" --title="Fedora Utils is up-to-date" --text="Fedora Utils is already the latest stable version." --button="Back:0"
            elif [[ ! "$updatestat" = "available" ]]; then
                show_warn "Could not check update"
                show_dialog --title="Could not check update" --text="An error occured and Fedora Utils was unable to check for update." --button="Back:0"
            fi;;
        "repo")
            add_repo "fedorautils.repo";;
        "issue")
            show_msg "Opening Browser"
            sudo -u "$user"  xdg-open "http://github.com/satya164/fedorautils/issues/new";;
        "wiki")
            show_msg "Opening Browser"
            sudo -u "$user"  xdg-open "http://github.com/satya164/fedorautils/wiki";;
        "changelog")
            show_msg "Fetching changelog"
            get_file_quiet "https://raw.github.com/satya164/fedorautils/master/CHANGELOG" "changelog.txt"
            if [[ -f changelog.txt ]]; then
                show_dialog --text-info --width=600 --height=600 --title="Changelog" --filename="changelog.txt" --button="Back:0"
                rm -f changelog.txt
            else
                show_err "Error fetching changelog! Do you have an active internet connection?"
            fi;;
        "logfile")
            if [[ -f "$logfile" ]]; then
                show_dialog --text-info --width=600 --height=600 --title="Logfile" --filename="$logfile" --button="Back:0"
            else
                show_err "No logfile exists. Try running fedorautils with logging enabled. Use --help for more details."
            fi;;
        esac
    done
done
}
