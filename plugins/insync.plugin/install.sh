#!/bin/bash

rpm --import https://d2t3ff60b2tol4.cloudfront.net/repomd.xml.key

cat > /etc/yum.repos.d/insync.repo << "EOF" 
[insync]
name=insync repo
baseurl=http://yum.insync.io/fedora/$releasever/
gpgcheck=1
gpgkey=https://d2t3ff60b2tol4.cloudfront.net/repomd.xml.key
enabled=1
metadata_expire=120m
EOF

dnf install -y insync
