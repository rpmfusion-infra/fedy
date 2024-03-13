#!/bin/bash

if [ -f /etc/yum.repos.d/mullvad-vpn.repo ]; then
  rm -f /etc/yum.repos.d/mullvad-vpn.repo
fi

dnf -y remove mullvad-vpn
