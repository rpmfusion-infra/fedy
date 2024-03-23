#!/bin/bash

cat > /etc/yum.repos.d/fortinet.repo << "EOF" 
[repo.fortinet.com]
name=Fortinet CentOS 7 repository
baseurl=https://repo.fortinet.com/repo/7.0/centos/8/os/x86_64/
enabled=1
gpgkey=https://repo.fortinet.com/repo/7.0/centos/8/os/x86_64/RPM-GPG-KEY
gpgcheck=1
EOF

dnf install forticlient -y
