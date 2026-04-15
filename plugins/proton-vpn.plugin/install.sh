#!/bin/bash

# Instructions adopted from
# https://protonvpn.com/support/official-linux-vpn-fedora

cat > /etc/yum.repos.d/protonvpn.repo << "EOF" 
#
# ProtonVPN stable release
#
[protonvpn-fedora-stable]
name = ProtonVPN Fedora Stable repository
baseurl = https://repo.protonvpn.com/fedora-$releasever-stable
enabled = 1
gpgcheck = 1
repo_gpgcheck=1
gpgkey = https://repo.protonvpn.com/fedora-$releasever-stable/public_key.asc
EOF

dnf install protonvpn -y

