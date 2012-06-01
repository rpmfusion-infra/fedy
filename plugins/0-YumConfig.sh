function U_T_YumConfig # Setup yum to keep cache
{
YumConfig
}

function YumConfig()
{
ShowFunc "Setting up yum to keep package cache"
s=`cat /etc/yum.conf | grep "keepcache=1"`
if [ -n "$s" ]; then
StatusMsg "Yum already configured to keep package cache"
else
	if [ "$KEEPBACKUP" = "YES" ]; then
	cp /etc/yum.conf /etc/yum.conf.bak
	fi
sed -i 's/keepcache=0/keepcache=1/g' /etc/yum.conf
fi
s=`cat /etc/yum.conf | grep "keepcache=1"`
if [ -n "$s" ]; then
Success
else
Failure
fi
}
