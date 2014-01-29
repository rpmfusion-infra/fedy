# Name: About
# Command: show_about

show_about() {
while :
do
    show_dialog --width=200 --height=200 --title="About $program" --text-align="center" --text="<b>$program</b>\n$version\nTweak your Fedora\nCopyright © Satyajit Sahoo" --button="Back:1" --button="Report bug:0"
    if [[ $? -eq 0 ]]; then
        show_msg "Opening Browser"
        sudo -u "$user" xdg-open "http://github.com/satya164/$unixname/issues/new"
    else
        break
    fi
done
}
