#!/bin/bash

if [ -f "/etc/yum.repos.d/yarn.repo" ]; then
  dnf -y remove yarn
  rm -f /etc/yum.repos.d/yarn.repo
fi
