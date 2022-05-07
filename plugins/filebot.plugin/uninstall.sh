#!/bin/bash

dnf -y remove anydesk

if [ -f "/etc/yum.repos.d/AnyDesk-Fedora.repo" ]; then
  rm -f /etc/yum.repos.d/AnyDesk-Fedora.repo
fi
