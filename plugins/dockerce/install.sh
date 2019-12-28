#!/bin/bash

dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo -y
dnf install docker-ce -y

usermod -aG docker ${USER}
systemctl enable docker
systemctl start docker
