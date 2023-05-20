#!/bin/bash

sudo dnf remove protonvpn -y

if [ -f "/etc/yum.repos.d/protonvpn.repo" ]; then
  rm -f /etc/yum.repos.d/protonvpn.repo
fi
