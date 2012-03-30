function P_F_FixNTFSConfig # Fix ntfs-config not starting
{
FixNTFSConfig
}

function FixNTFSConfig()
{
ShowFunc "Fixing ntfs-config"
if [ -d /etc/hal/fdi/policy ]; then
StatusMsg "ntfs-config already fixed"
else
mkdir -p /etc/hal/fdi/policy
fi
if [ -d /etc/hal/fdi/policy ]; then
Success
else
Failure
fi
}
