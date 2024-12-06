#!/bin/bash

# Instructions adopted from
# https://brave-browser.readthedocs.io/en/latest/installing-brave.html#linux

cat > /etc/yum.repos.d/brave-browser.repo << "EOF" 
[brave-browser]
name=Brave Browser
enabled=1
gpgcheck=1
gpgkey=https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
baseurl=https://brave-browser-rpm-release.s3.brave.com/$basearch
EOF

rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc

dnf -y install brave-browser
