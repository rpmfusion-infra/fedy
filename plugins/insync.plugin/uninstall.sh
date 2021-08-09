#!/bin/bash

dnf -y remove insync

if [ -f "/etc/yum.repos.d/insync.repo" ]; then
  rm -f /etc/yum.repos.d/insync.repo
fi
