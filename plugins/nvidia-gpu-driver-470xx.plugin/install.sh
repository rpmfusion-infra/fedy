#!/bin/bash

# https://rpmfusion.org/Howto/NVIDIA

dnf update -y
dnf install -y xorg-x11-drv-nvidia-470xx akmod-nvidia-470xx