function P_F_FixAnaconda # Fix anaconda runtime & revisor
{
FixAnaconda
}

function FixAnaconda()
{
if [ -e /usr/lib/anaconda-runtime/anaconda ]; then
StatusMsg "Revisor already fixed"
else
ln -s /usr/lib/anaconda /usr/lib/anaconda-runtime
fi
if [ -e /usr/lib/anaconda-runtime/anaconda ]; then
Success
else
Failure
fi
}
