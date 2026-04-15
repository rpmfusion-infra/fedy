#!/bin/bash

if dnf5 --version &>/dev/null; then
  dnf5 config-manager addrepo --from-repofile=https://cli.github.com/packages/rpm/gh-cli.repo
else
  dnf4 config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
fi

dnf -y install gh
