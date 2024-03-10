#!/bin/bash

dnf -y remove tailscale

if [ -f "/etc/yum.repos.d/tailscale.repo" ]; then
  rm -f /etc/yum.repos.d/tailscale.repo
fi
