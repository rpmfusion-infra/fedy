#!/bin/bash

rpm --import https://packages.microsoft.com/keys/microsoft.asc

if dnf5 --version &>/dev/null; then
  dnf config-manager addrepo --from-repofile=https://packages.microsoft.com/yumrepos/edge/config.repo --save-filename=microsoft-edge-stable --overwrite
else
  dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/edge
fi

dnf install microsoft-edge-stable -y
