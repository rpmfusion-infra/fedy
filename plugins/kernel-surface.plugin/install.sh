#!/bin/bash

# https://github.com/linux-surface/linux-surface/wiki/Installation-and-Setup
#

dnf -y config-manager --add-repo=https://pkg.surfacelinux.com/fedora/linux-surface.repo
dnf -y install --allowerasing kernel-surface iptsd libwacom-surface
dnf -y install surface-secureboot


