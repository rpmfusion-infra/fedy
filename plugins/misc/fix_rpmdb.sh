# Name: Fix rpmdb open failed error
# Command: fix_rpmdb

fix_rpmdb() {
show_func "Fixing rpmdb"
# Progress
show_progress &
PROGPID=$!
# Delete the rpmdb
rm -f /var/lib/rpm/__db*
# Rebuild the rpmdb
rpm --rebuilddb
# Kill progress
disown $PROGPID
kill $PROGPID > /dev/null 2>&1
echo "done"
exit_state
}
