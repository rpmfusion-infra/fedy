#!/bin/bash

# https://rpmfusion.org/Howto/NVIDIA

dnf remove -y xorg-x11-drv-nvidia-390xx kmod-nvidia-390xx\* akmod-nvidia-390xx
