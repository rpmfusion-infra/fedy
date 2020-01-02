#!/bin/bash

# https://rpmfusion.org/Howto/CUDA

if [ -f /etc/yum.repos.d/fedora-cuda.repo ] ; then
  rm -f /etc/yum.repos.d/fedora-cuda.repo
fi

if [ ! -f /etc/yum.repos.d/cuda-fedora29.repo ] ; then
  dnf -y config-manager --add-repo http://developer.download.nvidia.com/compute/cuda/repos/fedora29/x86_64/cuda-fedora29.repo
fi

testexclude=$(fgrep -c "^exclude=" /etc/yum.repos.d/cuda-fedora29.repo)

if [ ${testexclude} -eq 0 ] ; then
  echo "exclude=nvidia*,akmod-nvidia,kmod-nvidia*,dkms-nvidia" >> /etc/yum.repos.d/cuda-fedora29.repo 
fi

dnf install -y cuda
