#!/bin/bash

# Instructions adopted from
# http://rpm.anydesk.com/howto.html

cat > /etc/yum.repos.d/AnyDesk-Fedora.repo << "EOF" 
[anydesk]
name=AnyDesk Fedora - stable
baseurl=http://rpm.anydesk.com/fedora/$basearch/
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://keys.anydesk.com/repos/RPM-GPG-KEY
EOF

dnf config-manager --add-repo /etc/yum.repos.d/AnyDesk-Fedora.repo -y
dnf config-manager --set-enabled anydesk -y
dnf install anydesk -y
