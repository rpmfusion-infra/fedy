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
install_local http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-stable.noarch.rpm
}

rpmfusion-nonfree.repo() {
install_local http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-stable.noarch.rpm
}

infinality.repo() {
install_local http://www.infinality.net/fedora/linux/infinality-repo-1.0-1.noarch.rpm
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

adobe-linux.repo() {
install_local http://linuxdownload.adobe.com/adobe-release/adobe-release-1.0-0.noarch.rpm
}

fedora-cinnamon.repo() {
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
}

gtk-theme-config.repo() {
cat <<EOF | tee /etc/yum.repos.d/gtk-theme-config.repo
[gtk-theme-config]
name=GTK theme preferences (Fedora_17)
type=rpm-md
baseurl=http://download.opensuse.org/repositories/home:/satya164:/gtk-theme-config/Fedora_17/
gpgcheck=0
gpgkey=http://download.opensuse.org/repositories/home:/satya164:/gtk-theme-config/Fedora_17/repodata/repomd.xml.key
enabled=1
EOF
}

fedorautils.repo() {
cat <<EOF | tee /etc/yum.repos.d/fedorautils.repo
name=Fedora Utils
type=rpm-md
baseurl=http://download.opensuse.org/repositories/home:/satya164:/fedorautils/Fedora_17/
gpgcheck=1
gpgkey=http://download.opensuse.org/repositories/home:/satya164:/fedorautils/Fedora_17/repodata/repomd.xml.key
enabled=1
metadata_expire=1d
skip_if_unavailable=1
EOF
}
