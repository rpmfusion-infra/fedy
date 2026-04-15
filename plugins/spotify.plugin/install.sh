#!/bin/bash

if dnf5 --version &>/dev/null; then
  dnf5 config-manager setopt fedora-spotify.enabled=0 &>/dev/null || :
else
  dnf4 config-manager --set-disabled --repo=fedora-spotify -y &>/dev/null || :
fi

dnf -y install lpf-spotify-client
