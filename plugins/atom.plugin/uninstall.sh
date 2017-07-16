#!/bin/bash

# This block is for those who still have old copr installed
# will be removed after some time.

if [ -f /etc/yum.repos.d/_copr_mosquito-atom.repo ]; then
  rm -f /etc/yum.repos.d/_copr_mosquito-atom.repo
fi

dnf -y remove atom
