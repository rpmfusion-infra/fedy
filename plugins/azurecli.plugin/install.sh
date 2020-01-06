#!/bin/bash

gpgkey=$"https://packages.microsoft.com/keys/microsoft.asc"

rpm --import $gpgkey

cat <<EOF > /etc/yum.repos.d/azurecli.repo
[azurecli]
name=Azure Cli
baseurl=https://packages.microsoft.com/yumrepos/azure-cli
enabled=1
gpgcheck=1
gpgkey=$gpgkey
EOF

dnf -y install azure-cli
