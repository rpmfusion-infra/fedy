# Name: Configure yum to keep cache
# Command: yum_keepcache

yum_keepcache() {
show_func "Configuring yum to keep package cache"
if [[ "$(yum_keepcache_test)" = "Configured" && ! "$reinstall" = "yes" ]]; then
    show_status "Yum already configured to keep package cache"
else
    make_backup "/etc/yum.conf"
    sed -i 's/keepcache=.*$/keepcache=1/g' "/etc/yum.conf"
fi
[[ "$(yum_keepcache_test)" = "Configured" ]]; exit_state
}

yum_keepcache_undo() {
show_func "Configuring yum not to keep package cache"
make_backup "/etc/yum.conf"
sed -i 's/keepcache=.*$/keepcache=0/g' "/etc/yum.conf"
[[ ! "$(yum_keepcache_test)" = "Configured" ]]; exit_state
}

yum_keepcache_test() {
if [[ `grep "keepcache=1" /etc/yum.conf` ]]; then
    printf "Configured"
else
    printf "Not configured"
fi
}
