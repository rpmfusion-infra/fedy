#!/bin/bash

if [ -f '/etc/yum.repos.d/claude-desktop.repo' ] ; then
  rm '/etc/yum.repos.d/claude-desktop.repo'
fi

dnf remove -y claude-desktop-unofficial
