add_repo() {
while [[ $# -gt 0 ]]; do
	if [[ $1 =~ .repo$ ]]; then
		repofile="$1"
		show_msg "Adding $repofile"
		if [[ -f /etc/yum.repos.d/$repofile ]]; then
			show_status "$repofile already present"
		else
			eval "$repofile"
		fi
	fi
	shift
done
}

rpmfusion-free.repo() {
install_local http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-${fver}.noarch.rpm
}

rpmfusion-nonfree.repo() {
install_local http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-${fver}.noarch.rpm
}

livna.repo() {
install_local http://rpm.livna.org/livna-release.rpm http://ftp-stud.fht-esslingen.de/pub/Mirrors/rpm.livna.org/livna-release.rpm
# Disable Livna repo
sed -i 's/enabled=1/enabled=0/g' "/etc/yum.repos.d/livna.repo"
}

bumblebee.repo() {
install_local http://install.linux.ncsu.edu/pub/yum/itecs/public/bumblebee-nonfree/fedora${fver}/noarch/bumblebee-nonfree-release-1.0-1.noarch.rpm
}

adobe-linux-i386.repo() {
install_local http://linuxdownload.adobe.com/adobe-release/adobe-release-i386-1.0-1.noarch.rpm
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux
}

adobe-linux-x86_64.repo() {
install_local http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux
}

google.repo() {
rpm --import https://dl-ssl.google.com/linux/linux_signing_key.pub
cat <<EOF | tee /etc/yum.repos.d/google.repo
[Google] 
name=Google - $(uname -i)
baseurl=http://dl.google.com/linux/rpm/stable/$(uname -i)
enabled=1 
gpgcheck=1 
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub
EOF
}

skype.repo() {
cat <<EOF | tee /etc/yum.repos.d/skype.repo
[skype]
name=Skype Repository
baseurl=http://download.skype.com/linux/repos/fedora/updates/i586/
gpgkey=http://www.skype.com/products/skype/linux/rpm-public-key.asc
enabled=1
gpgcheck=0
EOF
}

steam.repo() {
cat <<EOF | tee /etc/yum.repos.d/steam.repo
[steam]
name=Steam RPM packages and dependencies
baseurl=http://spot.fedorapeople.org/steam/fedora-\$releasever/
enabled=1
skip_if_unavailable=1
gpgcheck=0
EOF
}

elegance-colors.repo() {
cat <<EOF | tee /etc/yum.repos.d/elegance-colors.repo
[elegance-colors]
name=Elegance Colors Gnome Shell theme
type=rpm-md
baseurl=http://download.opensuse.org/repositories/home:/satya164:/elegance-colors/Fedora_\$releasever/
gpgcheck=1
gpgkey=http://download.opensuse.org/repositories/home:/satya164:/elegance-colors/Fedora_\$releasever/repodata/repomd.xml.key
enabled=1
skip_if_unavailable=1
EOF
}

gtk-theme-config.repo() {
cat <<EOF | tee /etc/yum.repos.d/gtk-theme-config.repo
[gtk-theme-config]
name=GTK theme preferences
type=rpm-md
baseurl=http://download.opensuse.org/repositories/home:/satya164:/gtk-theme-config/Fedora_\$releasever/
gpgcheck=1
gpgkey=http://download.opensuse.org/repositories/home:/satya164:/gtk-theme-config/Fedora_\$releasever/repodata/repomd.xml.key
enabled=1
skip_if_unavailable=1
EOF
}

fedorautils.repo() {
cat <<EOF | tee /etc/yum.repos.d/fedorautils.repo
name=Fedora Utils
type=rpm-md
baseurl=http://download.opensuse.org/repositories/home:/satya164:/fedorautils/Fedora_\$releasever/
gpgcheck=1
gpgkey=http://download.opensuse.org/repositories/home:/satya164:/fedorautils/Fedora_\$releasever/repodata/repomd.xml.key
enabled=1
metadata_expire=1d
skip_if_unavailable=1
EOF
}
