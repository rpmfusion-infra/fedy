#!/bin/bash

# https://rpmfusion.org/Howto/CUDA

dnf install -y https://developer.download.nvidia.com/compute/machine-learning/repos/rhel7/x86_64/nvidia-machine-learning-repo-rhel7-1.0.0-1.x86_64.rpm
dnf install -y libcudnn7 libcudnn7-devel libnccl libnccl-devel
