# Name: Setup yum to keep cache
# Command: yum_config
# Value: False

yum_config() {
show_func "Setting up yum to keep package cache"
s=`grep "keepcache=1" /etc/yum.conf`
if [ -n "$s" ]; then
show_status "Yum already configured to keep package cache"
else
	if [ "$keepbackup" = "yes" ]; then
	cp /etc/yum.conf /etc/yum.conf.bak
	fi
sed -i 's/keepcache=0/keepcache=1/g' /etc/yum.conf
fi
s=`grep "keepcache=1" /etc/yum.conf`
[[ -n "$s" ]]; exit_state
}
