#!/bin/bash

cat <<EOF > /etc/yum.repos.d/network\:messaging\:xmpp\:dino.repo
[network_messaging_xmpp_dino]
name=Modern Jabber/XMPP Client using GTK+/Vala  (Fedora_\$releasever)
type=rpm-md
baseurl=http://download.opensuse.org/repositories/network:/messaging:/xmpp:/dino/Fedora_\$releasever/
gpgcheck=1
gpgkey=http://download.opensuse.org/repositories/network:/messaging:/xmpp:/dino/Fedora_\$releasever/repodata/repomd.xml.key
EOF

dnf config-manager --add-repo /etc/yum.repos.d/network\:messaging\:xmpp\:dino.repo -y
dnf config-manager --set-enabled network_messaging_xmpp_dino -y
dnf install dino -y
