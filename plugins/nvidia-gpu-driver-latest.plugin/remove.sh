#!/bin/bash

# https://rpmfusion.org/Howto/NVIDIA

dnf copr disable kwizart/nvidia-driver-rawhide -y
dnf remove -y xorg-x11-drv-nvidia kmod-nvidia\* akmod-nvidia
