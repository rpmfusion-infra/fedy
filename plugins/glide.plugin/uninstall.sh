#!/bin/bash

dnf -y remove glide-rs

if [ -f "/etc/yum.repos.d/_copr:copr.fedorainfracloud.org:atim:glide-rs.repo" ]; then
  rm -f /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:atim:glide-rs.repo
fi
