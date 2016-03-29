#!/bin/bash

dnf config-manager --add-repo=http://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo

dnf -y install binutils gcc make patch libgomp glibc-headers glibc-devel kernel-headers kernel-devel dkms

dnf -y install VirtualBox-5.0
