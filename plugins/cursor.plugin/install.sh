#!/bin/bash

# https://www.cursor.com/downloads

rpm --import https://downloads.cursor.com/keys/anysphere.asc

cat <<EOF > /etc/yum.repos.d/cursor.repo
[cursor]
name=Cursor
baseurl=https://downloads.cursor.com/yumrepo
enabled=1
gpgcheck=1
gpgkey=https://downloads.cursor.com/keys/anysphere.asc
repo_gpgcheck=1
EOF

dnf install -y cursor
