#!/bin/bash

if [ -f "/etc/yum.repos.d/mongodb.repo" ]; then
  dnf -y remove mongodb-org 
  rm -f /etc/yum.repos.d/mongodb.repo
fi
