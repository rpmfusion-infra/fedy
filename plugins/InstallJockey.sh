function U_T_InstallJockey # Install Jockey driver installer
{
InstallJockey
}

function InstallJockey()
{
ShowFunc "Installing Jockey driver installer"
if [ -e /usr/bin/jockey-gtk ] || [ -e /usr/bin/jockey-kde ]; then
StatusMsg "Jockey Driver Installer already installed"
else
RPMFusion
ParsidoraRepo
	if ( [ "$(pidof ksmserver)" ] ); then
	yum -y --enablerepo=parsidora install jockey-selinux jockey-kde
	else
	yum -y --enablerepo=parsidora install jockey-selinux jockey-gtk
	fi
fi
if [ -e /usr/bin/jockey-gtk ] || [ -e /usr/bin/jockey-kde ]; then
Success
else
Failure
fi
}
