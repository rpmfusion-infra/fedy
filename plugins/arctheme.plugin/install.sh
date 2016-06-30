#!/bin/bash

if [[ $(cat /etc/fedora-release | grep -o "[0-9]*") -ge 24 ]]; then
  dnf config-manager --add-repo=http://download.opensuse.org/repositories/home:Horst3180/Fedora_$(cat /etc/fedora-release | grep -o "[0-9]*")_standard/home:Horst3180.repo
else
  dnf config-manager --add-repo=http://download.opensuse.org/repositories/home:Horst3180/Fedora_$(cat /etc/fedora-release | grep -o "[0-9]*")/home:Horst3180.repo
fi
dnf -y install arc-theme
