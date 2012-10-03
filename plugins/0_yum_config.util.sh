# Name: Setup yum to keep cache
# Command: yum_config
# Value: False

yum_config() {
show_func "Setting up yum to keep package cache"
if [[ `grep "keepcache=1" /etc/yum.conf` ]]; then
	show_status "Yum already configured to keep package cache"
else
	make_backup "/etc/yum.conf"
	sed -i 's/keepcache=0/keepcache=1/g' "/etc/yum.conf"
fi
[[ `grep "keepcache=1" /etc/yum.conf` ]]; exit_state
}
