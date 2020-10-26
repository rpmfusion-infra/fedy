#!/bin/bash

# https://rpmfusion.org/Howto/CUDA

arch=$(uname -m)
cuda_arch=${arch}

# Architectural tweaks
if [ ${arch} == aarch64 ] ; then
  cuda_arch=sbsa
fi

dnf install -y https://developer.download.nvidia.com/compute/machine-learning/repos/rhel8/${cuda_arch}/nvidia-machine-learning-repo-rhel8-1.0.0-1.${arch}.rpm
