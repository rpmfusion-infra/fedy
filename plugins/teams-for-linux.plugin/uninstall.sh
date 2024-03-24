#!/bin/bash

dnf -y remove teams-for-linux

if [ -f "/etc/yum.repos.d/teams-for-linux.repo" ]; then
  rm -f /etc/yum.repos.d/teams-for-linux.repo
fi
