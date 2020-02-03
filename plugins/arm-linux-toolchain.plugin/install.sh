#!/bin/bash

# The Fedora toolchain is only suitable to build kernel and bootloaders
dnf remove binutils-arm-linux-gnu\* -y

# This toolchain additionnally can build user-space apps
dnf copr enable lantw44/arm-linux-gnueabi-toolchain -y
dnf install arm-linux-gnueabi-{binutils,gcc,glibc} -y
