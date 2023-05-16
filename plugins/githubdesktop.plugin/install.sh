#!/bin/bash

# Instructions adopted from
# https://github.com/shiftkey/desktop

cat > /etc/yum.repos.d/GithubDesktop-Fedora.repo << "EOF" 
[shiftkey]
name=GitHub Desktop
baseurl=https://rpm.packages.shiftkey.dev/rpm/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://rpm.packages.shiftkey.dev/gpg.key
EOF

dnf install github-desktop -y
