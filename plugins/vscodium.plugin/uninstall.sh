#!/bin/bash

if [ -f "/etc/yum.repos.d/vscodium.repo" ]; then
  dnf -y remove codium
  rm -f /etc/yum.repos.d/vscodium.repo
fi
