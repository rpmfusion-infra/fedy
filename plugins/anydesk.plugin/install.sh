#!/bin/bash

# Instructions adopted from
# http://rpm.anydesk.com/howto.html

cat > /etc/yum.repos.d/AnyDesk-Fedora.repo << "EOF" 
[anydesk]
name=AnyDesk Fedora - stable
baseurl=http://rpm.anydesk.com/fedora/$basearch/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://keys.anydesk.com/repos/RPM-GPG-KEY
EOF

dnf install anydesk -y
