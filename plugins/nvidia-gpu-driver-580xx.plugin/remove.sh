#!/bin/bash

# https://rpmfusion.org/Howto/NVIDIA

dnf remove -y xorg-x11-drv-nvidia-580xx kmod-nvidia-580xx\* akmod-nvidia-580xx
