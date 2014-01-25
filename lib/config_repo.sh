check_repo() {
yum repolist all 2>&1 | cut -d\  -f1 | cut -d/ -f1 | grep -ix "${1%.repo}" > /dev/null 2>&1
}

test_repo() {
get_file_quiet "$(yum -q repoinfo ${1%.repo} 2>&1 | grep Repo-baseurl | grep -o -E 'http(s?)://.*' | sed -e 's/$/repodata\/repomd.xml/')" /dev/null
}

config_repo() {
repouri="$1"
repofile=${repouri##*/}
show_msg "Adding $repofile"
get_file_quiet "$repouri" "$repofile"
if [[ `grep "^name=" "$repofile"` && `grep "^baseurl=" "$repofile"` ]]; then
    check_repo "$repofile"
    if [[ $? -eq 0 ]]; then
        show_status "$repofile already configured"
    else
        yum-config-manager --add-repo="$repofile"
        exit_state
    fi
else
    show_err "$repofile is malformed"
fi
}

add_repo() {
while [[ $# -gt 0 ]]; do
    if [[ $1 =~ .repo$ ]]; then
        repofile="$1"
        show_msg "Adding $repofile"
        check_repo "$repofile"
        if [[ $? -eq 0 ]]; then
            show_status "$repofile already configured"
        else
            eval "$repofile"
        fi
        test_repo "$repofile"
        if [[ ! $? -eq 0 ]]; then
            show_warn "$repofile is currently not available"
            reponame="${repofile%.repo}"
            yum-config-manager --save --setopt="${reponame}.skip_if_unavailable=1" --setopt="${reponame^}.skip_if_unavailable=1" > /dev/null 2>&1
        fi
    fi
    shift
done
}

remove_repo() {
while [[ $# -gt 0 ]]; do
    if [[ $1 =~ .repo$ ]]; then
        repofile="$1"
        rm -f "/etc/yum.repos.d/$repofile"
    fi
    shift
done
}

rpmfusion-free.repo() {
install_pkg http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-${fver}.noarch.rpm
}

rpmfusion-nonfree.repo() {
install_pkg http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-${fver}.noarch.rpm
}

livna.repo() {
install_pkg http://rpm.livna.org/livna-release.rpm http://ftp-stud.fht-esslingen.de/pub/Mirrors/rpm.livna.org/livna-release.rpm
# Disable Livna repo
yum-config-manager --disable livna > /dev/null 2>&1
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

skype.repo() {
cat <<EOF | tee /etc/yum.repos.d/skype.repo > /dev/null 2>&1
[skype]
name=Skype Repository
baseurl=http://download.skype.com/linux/repos/fedora/updates/i586/
gpgkey=http://www.skype.com/products/skype/linux/rpm-public-key.asc
enabled=1
gpgcheck=1
skip_if_unavailable=1
EOF
}

steam.repo() {
cat <<EOF | tee /etc/yum.repos.d/steam.repo > /dev/null 2>&1
[steam]
name=Steam RPM packages and dependencies
baseurl=http://spot.fedorapeople.org/steam/fedora-\$releasever/
enabled=1
gpgcheck=0
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

$unixname.repo() {
cat <<EOF | tee /etc/yum.repos.d/$unixname.repo > /dev/null 2>&1
[$unixname]
name=$program
type=rpm-md
baseurl=http://download.opensuse.org/repositories/home:/satya164:/$unixname/Fedora_\$releasever/
gpgkey=http://download.opensuse.org/repositories/home:/satya164:/$unixname/Fedora_\$releasever/repodata/repomd.xml.key
gpgcheck=1
enabled=1
metadata_expire=1d
skip_if_unavailable=1
EOF
}
