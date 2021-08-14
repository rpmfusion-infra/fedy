#!/bin/bash

if [ -f /etc/yum.repos.d/1password.repo ]; then
  rm -f /etc/yum.repos.d/1password.repo
fi

dnf -y remove 1password
