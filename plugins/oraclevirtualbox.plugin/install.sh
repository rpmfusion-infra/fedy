#!/bin/bash

dnf -y install binutils gcc make patch libgomp glibc-headers glibc-devel kernel-headers kernel-devel dkms

dnf -y install VirtualBox VirtualBox-guest-additions akmod-VirtualBox
