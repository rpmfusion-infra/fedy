#!/bin/bash

dnf -y remove anydesk

if [ -f "/etc/yum.repos.d/GithubDesktop-Fedora.repo" ]; then
  rm -f /etc/yum.repos.d/GithubDesktop-Fedora.repo
fi
