#!/bin/bash

cat <<EOF > /etc/yum.repos.d/yarn.repo
[yarn]
name=Yarn Repository
baseurl=https://dl.yarnpkg.com/rpm/
enabled=1
gpgcheck=1
gpgkey=https://dl.yarnpkg.com/rpm/pubkey.gpg

EOF

dnf -y install yarn
