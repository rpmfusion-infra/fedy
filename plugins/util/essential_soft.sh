# Name: Install essential software
# Command: essential_soft

softlist=( "cabextract" "lzip" "nano" "p7zip" "p7zip-plugins" "unrar" "wget" )

essential_soft() {
show_func "Installing essential software"
if [[ "$(essential_soft_test)" = "Installed" ]]; then
    show_status "Essential software already installed"
else
    add_repo "rpmfusion-free.repo" "rpmfusion-nonfree.repo"
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
query_pkg ${softlist[@]}
if [[ $? -eq 0 ]]; then
    printf "Installed"
else
    printf "Not installed"
fi
}
