# Name: Fix bad theme in root apps
# Command: fix_theme
# Value: False

fix_theme() {
show_func "Fixing bad theme in root apps"
[[ -d /root/.themes ]] && make_backup "/root/.themes"
[[ -d /root/.icons ]] && make_backup "/root/.icons"
ln -sf $homedir/.local/share/themes/ /root/.local/share
ln -sf $homedir/.themes/ /root
ln -sf $homedir/.icons/ /root
[[ -L /root/.themes ]]; exit_state
}
