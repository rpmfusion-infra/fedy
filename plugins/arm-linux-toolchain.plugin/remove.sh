#!/bin/bash

dnf remove arm-linux-gnueabi-{binutils,gcc,glibc}
dnf copr disable lantw44/arm-linux-gnueabi-toolchain -y
