#!/bin/bash

if dnf5 --version &>/dev/null; then
  dnf config-manager addrepo --from-repofile=https://download.docker.com/linux/fedora/docker-ce.repo
else
  dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo -y
fi

dnf install docker-ce -y

usermod -aG docker ${USER}
systemctl enable docker
systemctl start docker
