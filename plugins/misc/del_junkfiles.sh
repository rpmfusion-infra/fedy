# Name: Delete junk and backup files
# Command: del_junkfiles

del_junkfiles() {
show_func "Deleting junk and backup files"
show_msg "Deleting desktop.ini"
find /home/ -name 'desktop.ini' -delete
show_msg "Deleting Thumbs.db"
find /home/ -name 'Thumbs.db' -delete
show_msg "Deleting .DS_Store"
find /home/ -name '.DS_Store' -delete
show_msg "Deleting backup files"
find /home/ -name '*~' -delete
find /home/ -name '*.bak' -delete
find /home/ -name '*.BAK' -delete
exit_state
}
