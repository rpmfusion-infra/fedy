function P_F_FixRPMdb # Fix rpmdb open failed error
{
FixRPMdb
}

function FixRPMdb()
{
ShowFunc "Fixing rpmdb"
# Delete the rpmdb
rm -f /var/lib/rpm/__db*
# Rebuild the rpmdb
rpm --rebuilddb
Success
}
