#!/bin/bash

rpm --import https://packagecloud.io/slacktechnologies/slack/gpgkey

cat > /etc/yum.repos.d/slack.repo << 'EOF'
[slacktechnologies_slack]
name=slacktechnologies_slack
baseurl=https://packagecloud.io/slacktechnologies/slack/fedora/21/$basearch
repo_gpgcheck=1
gpgcheck=0
enabled=1
gpgkey=https://packagecloud.io/slacktechnologies/slack/gpgkey
sslverify=1
sslcacert=/etc/pki/tls/certs/ca-bundle.crt
metadata_expire=300
EOF

dnf install slack -y
