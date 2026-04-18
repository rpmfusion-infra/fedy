#!/bin/bash

if [ -f /etc/yum.repos.d/warpdotdev.repo ]; then
  rm -f /etc/yum.repos.d/warpdotdev.repo
fi

dnf -y remove warp-terminal
