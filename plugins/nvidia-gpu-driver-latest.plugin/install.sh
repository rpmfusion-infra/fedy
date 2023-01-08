#!/bin/bash

# https://rpmfusion.org/Howto/NVIDIA

if [ -f /etc/os-release ] ; then
	. /etc/os-release
fi

# NVIDIA Rawhide driver are currently only supported on f35+
if [ ${FEDORA_ID} -ge 35 ] ; then
  dnf copr enable kwizart/nvidia-driver-rawhide -y
  dnf install -y xorg-x11-drv-nvidia akmod-nvidia
fi
