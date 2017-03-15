#!/bin/bash

gpgkey=$"https://packages.microsoft.com/keys/microsoft.asc"

rpm --import $gpgkey

cat <<EOF > /etc/yum.repos.d/vscode.repo
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=$gpgkey
EOF

dnf -y install code
