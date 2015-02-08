rpmfusion-free.repo() {
install_pkg http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-${fver}.noarch.rpm
}

rpmfusion-nonfree.repo() {
install_pkg http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-${fver}.noarch.rpm
}

remi.repo() {
install_pkg http://rpms.famillecollet.com/fedora/remi-release-${fver}.rpm
}

adobe-linux-i386.repo() {
install_pkg http://linuxdownload.adobe.com/adobe-release/adobe-release-i386-1.0-1.noarch.rpm
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux
}

adobe-linux-x86_64.repo() {
install_pkg http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux
}

infinality.repo() {
install_pkg http://www.infinality.net/fedora/linux/infinality-repo-1.0-1.noarch.rpm
}

google.repo() {
rpm --import https://dl-ssl.google.com/linux/linux_signing_key.pub
cat <<EOF | tee /etc/yum.repos.d/google.repo > /dev/null 2>&1
[google]
name=Google - $(uname -i)
baseurl=http://dl.google.com/linux/rpm/stable/$(uname -i)
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub
enabled=1
gpgcheck=1
skip_if_unavailable=1
EOF
}

dropbox.repo() {
cat <<EOF | tee /etc/yum.repos.d/dropbox.repo > /dev/null 2>&1
[dropbox]
name=Dropbox Repository
baseurl=http://linux.dropbox.com/fedora/$releasever/
gpgkey=https://linux.dropbox.com/fedora/rpm-public-key.asc
enabled=1
skip_if_unavailable=1
EOF
}

elegance-colors.repo() {
cat <<EOF | tee /etc/yum.repos.d/elegance-colors.repo > /dev/null 2>&1
[elegance-colors]
name=Elegance Colors Gnome Shell theme
type=rpm-md
baseurl=http://download.opensuse.org/repositories/home:/satya164:/elegance-colors/Fedora_\$releasever/
gpgkey=http://download.opensuse.org/repositories/home:/satya164:/elegance-colors/Fedora_\$releasever/repodata/repomd.xml.key
gpgcheck=1
enabled=1
skip_if_unavailable=1
EOF
}

gtk-theme-config.repo() {
cat <<EOF | tee /etc/yum.repos.d/gtk-theme-config.repo > /dev/null 2>&1
[gtk-theme-config]
name=GTK theme preferences
type=rpm-md
baseurl=http://download.opensuse.org/repositories/home:/satya164:/gtk-theme-config/Fedora_\$releasever/
gpgkey=http://download.opensuse.org/repositories/home:/satya164:/gtk-theme-config/Fedora_\$releasever/repodata/repomd.xml.key
gpgcheck=1
enabled=1
skip_if_unavailable=1
EOF
}

numix.repo() {
cat <<EOF | tee /etc/yum.repos.d/numix.repo > /dev/null 2>&1
[numix]
name=Numix
type=rpm-md
baseurl=http://download.opensuse.org/repositories/home:/paolorotolo:/numix/Fedora_\$releasever/
gpgkey=http://download.opensuse.org/repositories/home:/paolorotolo:/numix/Fedora_\$releasever/repodata/repomd.xml.key
gpgcheck=1
enabled=1
skip_if_unavailable=1
EOF
}

fedy.repo() {
cat <<EOF | tee /etc/yum.repos.d/fedy.repo > /dev/null 2>&1
[fedy]
name=Fedy
type=rpm-md
baseurl=http://download.opensuse.org/repositories/home:/satya164:/fedy/Fedora_\$releasever/
gpgkey=http://download.opensuse.org/repositories/home:/satya164:/fedy/Fedora_\$releasever/repodata/repomd.xml.key
gpgcheck=1
enabled=1
metadata_expire=1d
skip_if_unavailable=1
EOF
}

moka-project.repo() {
cat <<EOF | tee /etc/yum.repos.d/moka-project.repo > /dev/null 2>&1
[moka-project]
name=Moka Project (Fedora_\$releasever)
type=rpm-md
baseurl=http://download.opensuse.org/repositories/home:/snwh:/moka-project/Fedora_\$releasever/
gpgkey=http://download.opensuse.org/repositories/home:/snwh:/moka-project/Fedora_\$releasever/repodata/repomd.xml.key
gpgcheck=1
enabled=1
skip_if_unavailable=1
EOF
}
