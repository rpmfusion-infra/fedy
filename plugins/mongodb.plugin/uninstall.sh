#!/bin/bash

dnf -y remove mongodb-org 

if [ -f "/etc/yum.repos.d/mongodb.repo" ]; then
  rm -f /etc/yum.repos.d/mongodb.repo
fi