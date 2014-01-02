# Name: Install GTK theme engines
# Command: theme_engines

theme_engines() {
show_func "Installing GTK theme engines"
if [[ "$(theme_engines_test)" = "Installed" && ! "$reinstall" = "yes" ]]; then
    show_status "GTK theme engines already installed"
else
    install_pkg gtk-murrine-engine gtk-unico-engine
fi
[[ "$(theme_engines_test)" = "Installed" ]]; exit_state
}

theme_engines_undo() {
show_func "Uninstalling GTK theme engines"
erase_pkg gtk-murrine-engine gtk-unico-engine
[[ ! "$(theme_engines_test)" = "Installed" ]]; exit_state
}

theme_engines_test() {
ls /usr/lib*/gtk-3.0/3.0.0/theming-engines/libunico.so > /dev/null 2>&1 && ls /usr/lib*/gtk-2.0/*/engines/libmurrine.so > /dev/null 2>&1
if [[ $? -eq 0 ]]; then
    printf "Installed"
else
    printf "Not installed"
fi
}
