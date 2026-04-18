#!/bin/bash

# https://www.enpass.io/support/kb/general/how-to-install-enpass-on-linux/

rpm --import https://yum.enpass.io/RPM-GPG-KEY-enpass-signing-key

if dnf5 --version &>/dev/null; then
  dnf5 config-manager addrepo --from-repofile=https://yum.enpass.io/enpass-yum.repo
else
  dnf4 config-manager --add-repo https://yum.enpass.io/enpass-yum.repo
fi

dnf install -y enpass
