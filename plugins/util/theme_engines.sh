# Name: Install GTK theme engines
# Command: theme_engines

enginelist=( "gtk-murrine-engine" "gtk-unico-engine" )

theme_engines() {
show_func "Installing GTK theme engines"
if [[ "$(theme_engines_test)" = "Installed" ]]; then
    show_status "GTK theme engines already installed"
else
    install_pkg ${enginelist[@]}
fi
[[ "$(theme_engines_test)" = "Installed" ]]; exit_state
}

theme_engines_undo() {
show_func "Uninstalling GTK theme engines"
erase_pkg ${enginelist[@]}
[[ ! "$(theme_engines_test)" = "Installed" ]]; exit_state
}

theme_engines_test() {
query_pkg ${enginelist[@]}
if [[ $? -eq 0 ]]; then
    printf "Installed"
else
    printf "Not installed"
fi
}
