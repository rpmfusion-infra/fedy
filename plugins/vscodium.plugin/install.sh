#!/bin/bash

gpgkey=$"https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg"

rpm --import $gpgkey

cat <<EOF > /etc/yum.repos.d/vscodium.repo
[gitlab.com_paulcarroty_vscodium_repo]
name=gitlab.com_paulcarroty_vscodium_repo
baseurl=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/repos/rpms/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg
EOF

dnf -y install codium
