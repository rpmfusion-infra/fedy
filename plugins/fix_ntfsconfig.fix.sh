# Name: Fix ntfs-config not starting
# Command: fix_ntfsconfig
# Value: False

fix_ntfsconfig() {
show_func "Fixing ntfs-config"
if [[ -d /etc/hal/fdi/policy ]]; then
show_status "ntfs-config already fixed"
else
mkdir -p /etc/hal/fdi/policy
fi
[[ -d /etc/hal/fdi/policy ]]; exit_state
}
