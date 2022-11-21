#!/bin/bash

# We assume the 'evil' 99.0.0-1 version is used if the repo is available
if [ -f /etc/wireguard/_copr:copr.fedorainfracloud.org:luminoso:Signal-Desktop.repo ] ; then
	rm /etc/wireguard/_copr:copr.fedorainfracloud.org:luminoso:Signal-Desktop.repo
	rpm -e signal-desktop
fi

cat<<"EOF" >"/etc/yum.repos.d/network:im:signal.repo"
[network_im_signal]
name=Signal Messaging Devel Project (Fedora_${releasever})
type=rpm-md
baseurl=https://download.opensuse.org/repositories/network:/im:/signal/Fedora_${releasever}/
gpgcheck=1
gpgkey=https://download.opensuse.org/repositories/network:/im:/signal/Fedora_${releasever}/repodata/repomd.xml.key
enabled=1
EOF

dnf install -y signal-desktop
