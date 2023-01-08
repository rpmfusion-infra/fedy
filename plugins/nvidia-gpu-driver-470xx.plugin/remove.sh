#!/bin/bash

# https://rpmfusion.org/Howto/NVIDIA

dnf remove -y xorg-x11-drv-nvidia-470xx kmod-nvidia-470xx\* akmod-nvidia-470xx
