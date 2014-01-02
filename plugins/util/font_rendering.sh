# Name: Improve font rendering
# Command: font_rendering

font_rendering() {
show_func "Improving font rendering"
if [[ "$(font_rendering_test)" = "Improved" && ! "$reinstall" = "yes" ]]; then
    show_status "Font rendering already improved"
else
    add_repo "infinality.repo"
    install_pkg_prevrel "infinality.repo" freetype-infinality fontconfig-infinality
fi
[[ "$(font_rendering_test)" = "Improved" ]]; exit_state
}

font_rendering_undo() {
show_func "Restoring original font rendering"
erase_pkg infinality-repo freetype-infinality fontconfig-infinality
remove_repo "infinality.repo"
[[ ! "$(font_rendering_test)" = "Improved" ]]; exit_state
}

font_rendering_test() {
ls /usr/lib*/freetype-infinality > /dev/null 2>&1
if [[ $? -eq 0 ]]; then
    printf "Improved"
else
    printf "Not improved"
fi
}
