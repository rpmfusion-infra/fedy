#!/bin/bash

dnf remove arm-linux-gnueabihf-{binutils,gcc,glibc}
dnf copr disable lantw44/arm-linux-gnueabihf-toolchain -y
