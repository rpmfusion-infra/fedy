# Name: Improve font rendering
# Command: font_rendering

infinalitylist=( "freetype-infinality" "fontconfig-infinality" )

font_rendering() {
show_func "Improving font rendering"
if [[ "$(font_rendering_test)" = "Improved" && ! "$reinstall" = "yes" ]]; then
    show_status "Font rendering already improved"
else
    add_repo "infinality.repo"
    install_pkg_prevrel "infinality.repo" ${infinalitylist[@]}
fi
[[ "$(font_rendering_test)" = "Improved" ]]; exit_state
}

font_rendering_undo() {
show_func "Restoring original font rendering"
erase_pkg ${infinalitylist[@]}
erase_pkg infinality-repo
remove_repo "infinality.repo"
[[ ! "$(font_rendering_test)" = "Improved" ]]; exit_state
}

font_rendering_test() {
query_pkg ${infinalitylist[@]}
if [[ $? -eq 0 ]]; then
    printf "Improved"
else
    printf "Not improved"
fi
}
