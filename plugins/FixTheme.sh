function P_F_FixTheme # Fix bad theme in root apps
{
FixTheme
}

function FixTheme()
{
ShowFunc "Fixing bad theme in root apps"
if [ "$KEEPBACKUP" = "YES" ] && [ -e /root/.themes ]; then
mv /root/.themes /root/.themes.bak
fi
ln -sf $HOMEDIR/.themes/ /root
ln -sf $HOMEDIR/.icons/ /root
if [ -e /root/.themes ]; then
Success
else
Failure
fi
}
