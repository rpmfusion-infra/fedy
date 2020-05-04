#!/bin/bash

dnf remove arm-linux-gnueabihf-{binutils,gcc,glibc} -y
dnf copr disable lantw44/arm-linux-gnueabihf-toolchain -y
