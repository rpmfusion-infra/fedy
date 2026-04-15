#!/bin/bash

# Instructions adopted from
# https://github.com/shiftkey/desktop

rpm --import https://mirror.mwt.me/shiftkey-desktop/gpgkey

cat > /etc/yum.repos.d/shiftkey-packages.repo << "EOF"
[mwt-packages]
name=GitHub Desktop
baseurl=https://mirror.mwt.me/shiftkey-desktop/rpm
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://mirror.mwt.me/shiftkey-desktop/gpgkey
EOF

dnf install github-desktop -y
