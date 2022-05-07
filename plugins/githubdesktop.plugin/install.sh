#!/bin/bash

# Instructions adopted from
# https://github.com/shiftkey/desktop

cat > /etc/yum.repos.d/GithubDesktop-Fedora.repo << "EOF" 
[shiftkey]
name=GitHub Desktop
baseurl=https://packagecloud.io/shiftkey/desktop/el/7/\$basearch
enabled=1
gpgcheck=0
repo_gpgcheck=1
gpgkey=https://mirror.mwt.me/ghd/gpgkey
EOF

dnf install github-desktop -y
