#!/bin/bash

# Instructions adopted from
# https://github.com/shiftkey/desktop

cat > /etc/yum.repos.d/GithubDesktop-Fedora.repo << "EOF" 
[shiftkey]
name=GitHub Desktop
baseurl=https://mirror.mwt.me/ghd/rpm
enabled=1
gpgcheck=0
repo_gpgcheck=1
gpgkey=https://mirror.mwt.me/ghd/gpgkey
EOF

dnf install github-desktop -y
