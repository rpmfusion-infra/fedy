#!/bin/bash

if [ -f "/etc/yum.repos.d/GithubDesktop-Fedora.repo" ]; then
  rm -f /etc/yum.repos.d/GithubDesktop-Fedora.repo
fi

dnf remove -y github-desktop