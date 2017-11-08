#!/bin/bash

rpm --import https://rpm.opera.com/rpmrepo.key

echo "[opera]
name=Opera packages
type=rpm-md
baseurl=https://rpm.opera.com/rpm
gpgcheck=1
gpgkey=https://rpm.opera.com/rpmrepo.key
enabled=1" | tee /etc/yum.repos.d/opera.repo

dnf -y install opera-stable
