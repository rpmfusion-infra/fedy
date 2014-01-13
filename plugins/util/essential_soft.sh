# Name: Install essential software
# Command: essential_soft

softlist=( "cabextract" "lzip" "nano" "p7zip" "p7zip-plugins" "unrar" "wget" )

essential_soft() {
show_func "Installing essential software"
if [[ "$(essential_soft_test)" = "Installed" && ! "$reinstall" = "yes" ]]; then
    show_status "Essential software already installed"
else
    add_repo "rpmfusion-nonfree.repo"
    install_pkg ${softlist[@]}
fi
[[ "$(essential_soft_test)" = "Installed" ]]; exit_state
}

essential_soft_undo() {
show_func "Uninstalling essential software"
erase_pkg ${softlist[@]}
[[ ! "$(essential_soft_test)" = "Installed" ]]; exit_state
}

essential_soft_test() {
for soft in ${softlist[@]}; do
    ls /usr/share/doc/$soft* > /dev/null 2>&1
    if [[ ! $? -eq 0 ]]; then
        softinstalled="no"
        break
    fi
done
if [[ ! "$softinstalled" = "no" ]]; then
    printf "Installed"
else
    printf "Not installed"
fi
}
