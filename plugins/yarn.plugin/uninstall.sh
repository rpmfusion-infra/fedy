#!/bin/bash

dnf -y remove yarn

if [ -f "/etc/yum.repos.d/yarn.repo" ]; then
  rm -f /etc/yum.repos.d/yarn.repo
fi
