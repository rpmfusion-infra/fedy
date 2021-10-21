#!/bin/bash

if [ -f "/etc/yum.repos.d/gh-cli.repo" ]; then
  rm -f /etc/yum.repos.d/gh-cli.repo
fi


dnf -y remove gh
