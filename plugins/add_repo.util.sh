# Name: Add additional repositories
# Command: add_repo
# Value: True

add_repo() {
show_func "Adding additional repos"
if [[ -f /etc/yum.repos.d/rpmfusion-free.repo && -f /etc/yum.repos.d/rpmfusion-nonfree.repo && -f /etc/yum.repos.d/google.repo && -f /etc/yum.repos.d/fedora-chromium-stable.repo && -f /etc/yum.repos.d/skype.repo ]]; then
show_status "Repos already added"
else
rpmfusionrepo
googlerepo
adoberepo
chromiumrepo
skyperepo
fi
[[ -f /etc/yum.repos.d/rpmfusion-free.repo && -f /etc/yum.repos.d/rpmfusion-nonfree.repo && -f /etc/yum.repos.d/google.repo && -f /etc/yum.repos.d/fedora-chromium-stable.repo && -f /etc/yum.repos.d/skype.repo ]]; exit_state
}

rpmfusionrepo() {
if [[ -f /etc/yum.repos.d/rpmfusion-free.repo ]]; then
show_status "RPM Fusion free repo already present"
else
install_local http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-stable.noarch.rpm
fi
if [[ -f /etc/yum.repos.d/rpmfusion-nonfree.repo ]]; then
show_status "RPM Fusion nonfree repo already present"
else
install_local http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-stable.noarch.rpm
fi
}

googlerepo() {
if [[ -f /etc/yum.repos.d/google.repo ]]; then
show_status "Google repo already present"
else
rpm --import https://dl-ssl.google.com/linux/linux_signing_key.pub -o linux_signing_key.pub
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

adoberepo() {
if [[ "$arch" = "32" ]]; then
	if [[ -f /etc/yum.repos.d/adobe-linux-i386.repo ]]; then
	show_status "Adobe repo already present"
	else
	install_local http://linuxdownload.adobe.com/adobe-release/adobe-release-i386-1.0-1.noarch.rpm
	fi
elif [[ "$arch" = "64" ]]; then
	if [[ -f /etc/yum.repos.d/adobe-linux-x86_64.repo ]]; then
	show_status "Adobe repo already present"
	else
	install_local http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm
	fi
fi
}

chromiumrepo() {
if [[ -f /etc/yum.repos.d/fedora-chromium-stable.repo ]]; then
show_status "Chromium repo already present"
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

skyperepo() {
if [[ -f /etc/yum.repos.d/skype.repo ]]; then
show_status "Skype repo already present"
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

parsidorarepo() {
if [[ -f /etc/yum.repos.d/parsidora.repo ]]; then
show_status "Parsidora repo already present"
else
cat <<EOF | tee /etc/yum.repos.d/parsidora.repo
[parsidora] 
name=Parsidora 16 – \$basearch
baseurl=http://parsidora.sourceforge.net/releases/16/repos/parsidora/\$basearch
enabled=0
gpgcheck=0
EOF
fi
}

cinnamonrepo() {
if [[ -f /etc/yum.repos.d/fedora-cinnamon.repo ]]; then
show_status "Cinnamon repo already present"
else
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

gtkthemeconfigrepo() {
if [[ -f /etc/yum.repos.d/gtk-theme-config.repo ]]; then
show_status "GTK theme preferences repo already present"
else
cat <<EOF | tee /etc/yum.repos.d/gtk-theme-config.repo
[gtk-theme-config]
name=GTK theme preferences (Fedora_17)
type=rpm-md
baseurl=http://download.opensuse.org/repositories/home:/satya164:/gtk-theme-config/Fedora_17/
gpgcheck=0
gpgkey=http://download.opensuse.org/repositories/home:/satya164:/gtk-theme-config/Fedora_17/repodata/repomd.xml.key
enabled=1
EOF
fi
}
