#!/bin/bash

if [ -f /etc/yum.repos.d/enpass-yum.repo ]; then
  rm -f /etc/yum.repos.d/enpass-yum.repo
fi

dnf -y remove enpass
