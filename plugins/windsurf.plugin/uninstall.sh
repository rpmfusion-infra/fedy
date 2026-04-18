#!/bin/bash

if [ -f /etc/yum.repos.d/windsurf.repo ]; then
  rm -f /etc/yum.repos.d/windsurf.repo
fi

dnf -y remove windsurf
