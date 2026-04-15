#!/bin/bash

if [ -f "/etc/yum.repos.d/shiftkey-packages.repo" ]; then
  rm -f /etc/yum.repos.d/shiftkey-packages.repo
fi

# Clean up legacy repo file name
if [ -f "/etc/yum.repos.d/GithubDesktop-Fedora.repo" ]; then
  rm -f /etc/yum.repos.d/GithubDesktop-Fedora.repo
fi

dnf remove -y github-desktop