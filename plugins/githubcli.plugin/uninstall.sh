#!/bin/bash

if [ -f "/etc/yum.repos.d/gh-cli.repo" ]; then
  dnf -y remove gh
  rm -f /etc/yum.repos.d/gh-cli.repo
fi
