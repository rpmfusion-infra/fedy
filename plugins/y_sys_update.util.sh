# Name: Update system
# Command: sys_update
# Value: False

sys_update() {
show_func "Updating system"
yum -y --skip-broken update
exit_state
}
