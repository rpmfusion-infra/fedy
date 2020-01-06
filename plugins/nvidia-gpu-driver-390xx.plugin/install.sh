#!/bin/bash

# https://rpmfusion.org/Howto/NVIDIA

dnf update -y
dnf install -y xorg-x11-drv-nvidia-390xx akmod-nvidia-390xx
