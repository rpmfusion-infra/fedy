#!/bin/bash

if dnf5 --version &>/dev/null; then
  dnf config-manager setopt fedora-spotify.enabled=0 &>/dev/null || :
else
  dnf config-manager --set-disabled --repo=fedora-spotify -y &>/dev/null || :
fi

dnf -y install lpf-spotify-client
