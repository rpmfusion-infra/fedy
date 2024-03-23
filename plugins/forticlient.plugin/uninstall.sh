#!/bin/bash

dnf -y remove forticlient

if [ -f "/etc/yum.repos.d/fortinet.repo" ]; then
  rm -f etc/yum.repos.d/fortinet.repo
fi
