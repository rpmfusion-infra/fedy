# Name: Setup yum to keep cache
# Command: yum_config

yum_config() {
show_func "Setting up yum to keep package cache"
if [[ "$(yum_config_test)" = "Enabled" ]]; then
	show_status "Yum already configured to keep package cache"
else
	make_backup "/etc/yum.conf"
	sed -i 's/keepcache=0/keepcache=1/g' "/etc/yum.conf"
fi
[[ "$(yum_config_test)" = "Enabled" ]]; exit_state
}

yum_config_test() {
if [[ `grep "keepcache=1" /etc/yum.conf` ]]; then
	printf "Enabled"
else
	printf "Disabled"
fi
}
