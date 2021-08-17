#!/bin/bash

dnf -y remove wike

if [ -f "/etc/yum.repos.d/_copr:copr.fedorainfracloud.org:xfgusta:wike.repo" ]; then
  rm -f /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:xfgusta:wike.repo
fi
