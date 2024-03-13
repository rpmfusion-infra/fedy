#!/bin/bash

# Instructions adopted from
# http://rpm.anydesk.com/howto.html

cat > /etc/yum.repos.d/tailscale.repo << "EOF" 
[tailscale]
name=Tailscale stable
baseurl=https://pkgs.tailscale.com/stable/fedora/$basearch
enabled=1
type=rpm
repo_gpgcheck=1
gpgcheck=0
gpgkey=https://pkgs.tailscale.com/stable/fedora/repo.gpg
EOF

dnf install tailscale -y
systemctl enable --now tailscaled
