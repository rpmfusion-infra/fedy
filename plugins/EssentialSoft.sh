function U_T_EssentialSoft # Install essential software
{
EssentialSoft
}

function EssentialSoft()
{
ShowFunc "Installing essential software"
if [ -e /usr/bin/cabextract ] && [ -e /usr/bin/dconf-editor ] && [ -d /usr/share/doc/p7zip-plugins* ] && [ -e /usr/bin/wget ] && [ -e /usr/bin/lzma ] && [ -e /usr/bin/unrar ] && [ -e /usr/lib/yum-plugins/fastestmirror.py ]; then
StatusMsg "Essential software already installed"
else
InstallPkg cabextract dconf-editor p7zip p7zip-plugins wget xz-lzma-compat unrar yum-plugin-fastestmirror
fi
if [ -e /usr/bin/cabextract ] && [ -e /usr/bin/dconf-editor ] && [ -d /usr/share/doc/p7zip-plugins* ] && [ -e /usr/bin/wget ] && [ -e /usr/bin/lzma ] && [ -e /usr/bin/unrar ] && [ -e /usr/lib/yum-plugins/fastestmirror.py ]; then
Success
else
Failure
fi
}
