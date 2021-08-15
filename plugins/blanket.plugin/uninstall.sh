#!/bin/bash

dnf -y remove blanket

if [ -f "/etc/yum.repos.d/_copr:copr.fedorainfracloud.org:tuxino:blanket.repo" ]; then
  rm -f /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:tuxino:blanket.repo
fi
