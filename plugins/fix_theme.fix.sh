# Name: Fix bad theme in root apps
# Command: fix_theme
# Value: False

fix_theme() {
show_func "Fixing bad theme in root apps"
if [[ "$keepbackup" = "yes" && -e /root/.themes ]]; then
mv /root/.themes /root/.themes.bak
fi
ln -sf $homedir/.themes/ /root
ln -sf $homedir/.icons/ /root
[[ -e /root/.themes ]]; exit_state
}
