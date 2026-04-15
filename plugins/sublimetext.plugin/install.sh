#!/bin/bash

rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg

if dnf5 --version &>/dev/null; then
  dnf config-manager addrepo --from-repofile=https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
else
  dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
fi

dnf -y install sublime-text
