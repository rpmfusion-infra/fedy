#!/bin/bash

#doc: https://support.1password.com/install-linux/

rpm --import https://downloads.1password.com/linux/keys/1password.asc

sh -c 'echo -e "[1password]\nname=1Password Stable Channel\nbaseurl=https://downloads.1password.com/linux/rpm/stable/\$basearch\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=\"https://downloads.1password.com/linux/keys/1password.asc\"" > /etc/yum.repos.d/1password.repo'

dnf install -y  1password
