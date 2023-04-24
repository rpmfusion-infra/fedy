#!/bin/bash

if [ -f /etc/yum.repos.d/linux-surface.repo ]; then
  rm -f /etc/yum.repos.d/linux-surface.repo
fi

dnf remove -y kernel-surface iptsd libwacom-surface
dnf remove -y surface-secureboot
