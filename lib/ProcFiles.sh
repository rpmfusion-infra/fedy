function InstallPkg()
{
yum -y install --nogpgcheck "$@"
}

function InstallLocalPkg()
{
yum -y localinstall --nogpgcheck "$@"
}

function ProcessPkg()
{
if [ $(uname -i) = "i386" ]; then
file="$file32"
get="$get32"
elif [ $(uname -i) = "x86_64" ]; then
file="$file64"
get="$get64"
fi
GetFile
InstallLocalPkg "$file"
}
