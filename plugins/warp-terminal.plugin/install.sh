#!/bin/bash

# https://www.warp.dev/download

rpm --import https://releases.warp.dev/linux/keys/warp.asc

cat >/etc/yum.repos.d/warpdotdev.repo <<EOF
[warpdotdev]
name=warpdotdev
baseurl=https://releases.warp.dev/linux/rpm/stable
enabled=1
gpgcheck=1
gpgkey=https://releases.warp.dev/linux/keys/warp.asc
EOF

dnf install -y warp-terminal
