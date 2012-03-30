function U_F_SysUpdate # Update system
{
SysUpdate
}

function SysUpdate()
{
ShowFunc "Updating system"
yum -y --skip-broken update
if [ $? = "0" ]; then
Success
else
Failure
fi
}
