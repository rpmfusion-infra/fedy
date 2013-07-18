# Name: Fix rpmdb open failed error
# Command: fix_rpmdb

fix_rpmdb() {
show_func "Fixing rpmdb open failed error"
# Delete the rpmdb
rm -f /var/lib/rpm/__db*
# Rebuild the rpmdb
rpm --rebuilddb
exit_state
}
