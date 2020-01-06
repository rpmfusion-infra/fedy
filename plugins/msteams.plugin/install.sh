#!/bin/bash

gpgkey=$"https://packages.microsoft.com/keys/microsoft.asc"

rpm --import $gpgkey

cat <<EOF > /etc/yum.repos.d/msteams.repo
[msteams]
name=Microsoft Teams
baseurl=https://packages.microsoft.com/yumrepos/ms-teams/
enabled=1
gpgcheck=1
gpgkey=$gpgkey
EOF

dnf -y install teams
