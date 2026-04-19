#!/bin/bash

if dnf5 --version &>/dev/null; then
  dnf5 copr enable maltekiefer/fedora-extras -y
else
  dnf4 copr enable maltekiefer/fedora-extras -y
fi

dnf -y install epson-inkjet-printer-escpr2
