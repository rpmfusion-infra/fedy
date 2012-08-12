# Name: Fix rpmdb open failed error
# Command: fix_rpmdb
# Value: False

fix_rpmdb() {
show_func "Fixing rpmdb"
# Delete the rpmdb
rm -f /var/lib/rpm/__db*
# Rebuild the rpmdb
rpm --rebuilddb
exit_state
}
