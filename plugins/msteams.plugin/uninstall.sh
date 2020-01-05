#!/bin/bash

if [ -f "/etc/yum.repos.d/msteams.repo" ]; then
  dnf -y remove teams
  rm -f /etc/yum.repos.d/msteams.rep
fi
