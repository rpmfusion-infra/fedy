#!/bin/bash

# Instructions adopted from
# https://github.com/brave/browser-laptop/blob/master/docs/linuxInstall.md#fedora-x86_64

dnf config-manager --add-repo https://s3-us-west-2.amazonaws.com/brave-rpm-release/x86_64/
rpm --import https://s3-us-west-2.amazonaws.com/brave-rpm-release/keys.asc
dnf -y install brave
