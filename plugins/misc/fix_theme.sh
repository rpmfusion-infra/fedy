# Name: Fix bad theme in root apps
# Command: fix_theme

fix_theme() {
show_func "Fixing bad theme in root apps"
[[ -d /root/.local/share/themes ]] && make_backup "/root/.local/share/themes"
[[ -d /root/.themes ]] && make_backup "/root/.themes"
[[ -d /root/.icons ]] && make_backup "/root/.icons"
ln -sf $homedir/.local/share/themes /root/.local/share/themes
ln -sf $homedir/.themes /root/.themes
ln -sf $homedir/.icons /root/.icons
[[ -L /root/.themes ]]; exit_state
}
