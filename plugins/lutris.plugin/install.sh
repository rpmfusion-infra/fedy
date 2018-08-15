#!/bin/bash

#Get Fedora version
Release=$(rpm -E %fedora)

#Add repo
dnf config-manager --add-repo https://download.opensuse.org/repositories/home:strycore/Fedora_${Release}/home:strycore.repo

#Install
dnf -y install lutris
