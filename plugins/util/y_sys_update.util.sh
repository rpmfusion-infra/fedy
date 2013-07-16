# Name: Update system
# Command: sys_update

sys_update() {
show_func "Updating system"
yum -y --skip-broken update
exit_state
}
