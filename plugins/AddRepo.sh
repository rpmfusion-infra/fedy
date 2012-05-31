function U_T_AddRepo # Add additional repositories
{
AddRepo
}

function AddRepo()
{
ShowFunc "Adding additional repos"
if [ -f /etc/yum.repos.d/rpmfusion-free.repo ] && [ -f /etc/yum.repos.d/rpmfusion-nonfree.repo ] && [ -f /etc/yum.repos.d/google.repo ] && [ -f /etc/yum.repos.d/fedora-chromium-stable.repo ] && [ -f /etc/yum.repos.d/skype.repo ]; then
StatusMsg "Repos already added"
else
RPMFusion
GoogleRepo
AdobeRepo
ChromiumRepo
SkypeRepo
fi
if [ -f /etc/yum.repos.d/rpmfusion-free.repo ] && [ -f /etc/yum.repos.d/rpmfusion-nonfree.repo ] && [ -f /etc/yum.repos.d/google.repo ] && [ -f /etc/yum.repos.d/fedora-chromium-stable.repo ] && [ -f /etc/yum.repos.d/skype.repo ]; then
Success
else
Failure
fi
}

function RPMFusion()
{
# Set up RPM Fusion
if [ -f /etc/yum.repos.d/rpmfusion-free.repo ]; then
StatusMsg "RPM Fusion free repo already present"
else
InstallLocalPkg http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-stable.noarch.rpm
fi
if [ -f /etc/yum.repos.d/rpmfusion-nonfree.repo ]; then
StatusMsg "RPM Fusion nonfree repo already present"
else
InstallLocalPkg http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-stable.noarch.rpm
fi
}

function GoogleRepo()
{
# Add Google Repo
if [ -f /etc/yum.repos.d/google.repo ]; then
StatusMsg "Google repo already present"
else
curl -s https://dl-ssl.google.com/linux/linux_signing_key.pub -o linux_signing_key.pub
rpm --import linux_signing_key.pub
rm -f linux_signing_key.pub
cat <<EOF | tee /etc/yum.repos.d/google.repo
[Google] 
name=Google - $(uname -i)
baseurl=http://dl.google.com/linux/rpm/stable/$(uname -i)
enabled=1 
gpgcheck=1 
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub
EOF
fi
}

function AdobeRepo()
{
# Set up Adobe Repo
if [ $(uname -i) = "i386" ]; then
	if [ -f /etc/yum.repos.d/adobe-linux-i386.repo ]; then
	StatusMsg "Adobe repo already present"
	else
	InstallLocalPkg http://linuxdownload.adobe.com/adobe-release/adobe-release-i386-1.0-1.noarch.rpm
	fi
elif [ $(uname -i) = "x86_64" ]; then
	if [ -f /etc/yum.repos.d/adobe-linux-x86_64.repo ]; then
	StatusMsg "Adobe repo already present"
	else
	InstallLocalPkg http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm
	fi
fi
}

function ChromiumRepo()
{
# Add Chromium Repo
if [ -f /etc/yum.repos.d/fedora-chromium-stable.repo ]; then
StatusMsg "Chromium repo already present"
else
cat <<EOF | tee /etc/yum.repos.d/fedora-chromium-stable.repo
[fedora-chromium-stable]
name=Builds of the "stable" tag of the Chromium Web Browser
baseurl=http://repos.fedorapeople.org/repos/spot/chromium-stable/fedora-\$releasever/\$basearch/
enabled=1
skip_if_unavailable=1
gpgcheck=0

[fedora-chromium-stable-source]
name=Builds of the "stable" tag of the Chromium Web Browser - Source
baseurl=http://repos.fedorapeople.org/repos/spot/chromium-stable/fedora-\$releasever/SRPMS
enabled=0
skip_if_unavailable=1
gpgcheck=0
EOF
fi
}

function SkypeRepo()
{
# Add Skype Repo
if [ -f /etc/yum.repos.d/skype.repo ]; then
StatusMsg "Skype repo already present"
else
cat <<EOF | tee /etc/yum.repos.d/skype.repo
[skype]
name=Skype Repository
baseurl=http://download.skype.com/linux/repos/fedora/updates/i586/
#gpgkey=http://www.skype.com/products/skype/linux/rpm-public-key.asc
enabled=1
gpgcheck=0
EOF
fi
}

function ParsidoraRepo()
{
if [ -f /etc/yum.repos.d/parsidora.repo ]; then
StatusMsg "Parsidora repo already present"
else
# Add Parsidora Repo
cat <<EOF | tee /etc/yum.repos.d/parsidora.repo
[parsidora] 
name=Parsidora 16 – \$basearch
baseurl=http://parsidora.sourceforge.net/releases/16/repos/parsidora/\$basearch
enabled=0
gpgcheck=0
EOF
fi
}

function CinnamonRepo()
{
if [ -f /etc/yum.repos.d/fedora-cinnamon.repo ]; then
StatusMsg "Cinnamon repo already present"
else
# Add Cinnamon Repo
cat <<EOF | tee /etc/yum.repos.d/fedora-cinnamon.repo
[fedora-cinnamon]
name=Cinnamon provides core user interface functions \for the GNOME 3 desktop
baseurl=http://repos.fedorapeople.org/repos/leigh123linux/cinnamon/fedora-\$releasever/\$basearch/
enabled=1
skip_if_unavailable=1
gpgcheck=0

[fedora-cinnamon-source]
name=Cinnamon provides core user interface functions \for the GNOME 3 desktop - Source
baseurl=http://repos.fedorapeople.org/repos/leigh123linux/cinnamon/fedora-\$releasever/SRPMS
enabled=0
skip_if_unavailable=1
gpgcheck=0
EOF
fi
}

function FedoraUtilsRepo()
{
if [ -f /etc/yum.repos.d/fedorautils.repo ]; then
StatusMsg "Fedora Utils repo already present"
else
# Add Fedora Utils Repo
cat <<EOF | tee /etc/yum.repos.d/fedorautils.repo
[fedorautils]
name=Fedora Utils
baseurl=http://master.dl.sourceforge.net/project/fedorautils/
enabled=1
metadata_expire=1d
skip_if_unavailable=1
gpgcheck=0
EOF
fi
}
