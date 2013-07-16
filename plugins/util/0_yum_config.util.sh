# Name: Configure yum to keep cache
# Command: yum_config

yum_config() {
show_func "Configuring yum to keep package cache"
if [[ "$(yum_config_test)" = "Configured" ]]; then
	show_status "Yum already configured to keep package cache"
else
	make_backup "/etc/yum.conf"
	sed -i 's/keepcache=.*$/keepcache=1/g' "/etc/yum.conf"
fi
[[ "$(yum_config_test)" = "Configured" ]]; exit_state
}

yum_config_test() {
if [[ `grep "keepcache=1" /etc/yum.conf` ]]; then
	printf "Configured"
else
	printf "Not configured"
fi
}
