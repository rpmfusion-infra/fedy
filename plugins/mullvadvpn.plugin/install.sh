#!/bin/bash

# https://mullvad.net/en/download/vpn/linux
if dnf5 --version &>/dev/null; then
  dnf config-manager addrepo --from-repofile=https://repository.mullvad.net/rpm/stable/mullvad.repo
else
  dnf config-manager --add-repo https://repository.mullvad.net/rpm/stable/mullvad.repo
fi

dnf install mullvad-vpn -y

